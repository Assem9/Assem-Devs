import 'package:my_portfolio/data/firestore_services/portfolio_services.dart';
import 'package:my_portfolio/data/models/personal_data.dart';

class PortfolioDataRepo{
  final PortfolioFirebaseServices portfolioFirebaseServices ;
  PortfolioDataRepo(this.portfolioFirebaseServices);

  Future<PersonalData> getPersonalData()async{
    final user = await portfolioFirebaseServices.getPersonalDataDocument();
    return PersonalData.fromJson(user.data() as Map<String,dynamic>)  ;
  }

}