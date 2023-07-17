import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_portfolio/data/models/Project.dart';

class AdminDataServices {
  FirebaseFirestore firesStore = FirebaseFirestore.instance ;
  Future<DocumentReference<Map<String, dynamic>>> addNewProjectToFireStore(Project project)async{
    return await firesStore.collection('projects').add(project.toMap()) ;
  }

  Future<void> updateProjectToFireStore(Project project)async{
    return await firesStore
        .collection('projects')
        .doc(project.iD)
        .update(project.toMap()) ;
  }

}