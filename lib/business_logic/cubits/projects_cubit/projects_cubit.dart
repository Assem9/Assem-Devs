import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/business_logic/cubits/projects_cubit/projects_states.dart';
import '../../../utils/strings.dart';
import '../../../data/firestore_services/project_firebase_services.dart';
import '../../../data/models/Project.dart';
import '../../../data/repositories/projects_repo.dart';

class ProjectsCubit extends Cubit<ProjectsStates>{
  ProjectsCubit() :super(InitialState());
  static ProjectsCubit get(context) => BlocProvider.of(context) ;
  final ProjectsRepo projectsRepo = ProjectsRepo(ProjectsFirebaseServices()) ;

  List<Project> myProjects = [];
  void getAllMyProjects(context)async{
    try{
      myProjects = await projectsRepo.getAllProjects();
      //myProjects = myProjects  + myProjects + myProjects ;
      initGridDimensions(context) ;
      emit(ProjectsLoaded());
    }catch(e){
      emit(ProjectDataLoadingError());
    }

  }

  void getProjectData(Project? project,String iD)async{
     if(project !=null){
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


  double girdHeight = 660 ;
  double increasedHeight = 200 ;

  void initGridDimensions(context){
    if(MediaQuery.of(context).size.width < 800){
      girdHeight = (MediaQuery.of(context).size.width)/1.5 + (myProjects.length * 5);
    }else{
      girdHeight = (MediaQuery.of(context).size.width*0.8)/1.5/2  +(myProjects.length * 5);
    }
  }

  void changeGridHeight(context,int crossItems){
    if(MediaQuery.of(context).size.width < 800){
      increasedHeight = (MediaQuery.of(context).size.width - 20)/(1.5)+ 10;
    }else{
      increasedHeight = (MediaQuery.of(context).size.width *0.8)/(1.5 * 2) + 10;
    }
    int noOfColumProjects = myProjects.length;
    if( noOfColumProjects % 2 ==1 && crossItems == 2){
      noOfColumProjects += 1 ;
    }
    //print('increase: ${increasedHeight}- $crossItems -$girdHeight - $noOfColumProjects');
    if(girdHeight < (increasedHeight * (noOfColumProjects/crossItems))){
      girdHeight += increasedHeight;
    }else{
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('No More Projects'),
        backgroundColor: Colors.red,
      ));
    }
    emit(ChangingGridSize());
  }

}