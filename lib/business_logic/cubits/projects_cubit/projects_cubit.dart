import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/business_logic/cubits/projects_cubit/projects_states.dart';
import '../../../constants/strings.dart';
import '../../../data/firestore_services/project_firebase_services.dart';
import '../../../data/models/Project.dart';
import '../../../data/repositories/projects_repo.dart';

class ProjectsCubit extends Cubit<ProjectsStates>{
  ProjectsCubit() :super(InitialState());
  static ProjectsCubit get(context) => BlocProvider.of(context) ;
  final ProjectsRepo projectsRepo = ProjectsRepo(ProjectsFirebaseServices()) ;

  List<Project> myProjects = [];
  void getAllMyProjects()async{
    try{
      myProjects = await projectsRepo.getAllProjects();
      emit(ProjectsLoaded());
    }catch(e){
      debugPrint('$e');
    }

  }


  void getProjectData(Project? project,String iD)async{
     if(project !=null){
       print('original');
       pickedPro = project ;
       emit(ProjectDataLoaded());
     }else{
       var projectId = iD.replaceFirst("project", "");
       getProjectDataFromApi(projectId);
     }

  }

  Project? pickedPro ;
  void getProjectDataFromApi(String iD){
    projectsRepo.getProjectData(iD).then((value){
      pickedPro = value ;
      emit(ProjectDataLoaded());
    }).catchError((e){
      debugPrint('$e');
      emit(ProjectDataLoadingError());
    });
  }

  String getProjectUrl(Project project){
    String projectUrl = '' ;
    for(String url in projectsUrl){
      if(url.contains(project.iD)){
        projectUrl = url ;
        break ;
      }
    }
    return projectUrl ;
  }

}