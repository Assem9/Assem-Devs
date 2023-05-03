import 'package:cloud_firestore/cloud_firestore.dart';

class ProjectsFirebaseServices{
  FirebaseFirestore firesStore = FirebaseFirestore.instance ;

  Future<QuerySnapshot<Map<String, dynamic>>> getProjectsDocuments() async{
    return firesStore
        .collection('projects')
        .get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getProjectDocument(String iD) async{
    return firesStore
        .collection('projects')
        .doc(iD)
        .get();
  }
}