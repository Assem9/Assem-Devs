import 'package:my_portfolio/data/models/Project.dart';

import '../firestore_services/project_firebase_services.dart';

class ProjectsRepo{
  final ProjectsFirebaseServices projectsFirebaseServices ;

  ProjectsRepo(this.projectsFirebaseServices);

  Future<List<Project>> getAllProjects()async{
    List<Project> projects = [] ;
    await projectsFirebaseServices.getProjectsDocuments().then((value){
      for (var element in value.docs) {
        projects.add(Project.fromJson(element.data()));
      }
      return projects ;
    });
    return projects ;
  }

  Future<Project> getProjectData(iD)async{
    Project project ;
    var projectDoc = await projectsFirebaseServices.getProjectDocument(iD) ;
    project = Project.fromJson(projectDoc.data() as Map<String ,dynamic>);
    return project;
  }

}