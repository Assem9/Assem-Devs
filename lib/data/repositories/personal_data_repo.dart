import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_portfolio/data/firestore_services/portfolio_services.dart';
import 'package:my_portfolio/data/models/personal_data.dart';

import '../models/customer_message.dart';

class PortfolioDataRepo{
  final PortfolioFirebaseServices portfolioFirebaseServices ;
  PortfolioDataRepo(this.portfolioFirebaseServices);

  Future<PersonalData> getPersonalData()async{
    final user = await portfolioFirebaseServices.getPersonalDataDocument();
    return PersonalData.fromJson(user.data() as Map<String,dynamic>)  ;
  }

  Future<DocumentReference<Map<String, dynamic>>> createCustomerMessage({
    required String msg
  })async{
    var message = CustomerMessage(
        dateTime: DateTime.now().toString(),
        message: msg
    );
    return await portfolioFirebaseServices.createUserMessageDocument(msg: message) ;
  }

}