import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_portfolio/data/models/personal_data.dart';

class PortfolioFirebaseServices {

  FirebaseFirestore firesStore = FirebaseFirestore.instance ;

  Future<DocumentSnapshot<Map<String, dynamic>>> getPersonalDataDocument() async{
    return firesStore
        .collection('personal')
        .doc('personal_data_contacts')
        .get() ;
  }

  Future<void> updatePersonalData ({required PersonalData data})async{
    return await firesStore
        .collection('personal')
        .doc('personal_data_contacts')
        .update(data.toMap());
  }

}