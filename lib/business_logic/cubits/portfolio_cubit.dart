import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_states.dart';
import 'package:my_portfolio/data/models/personal_data.dart';
import 'package:my_portfolio/data/models/screen_size.dart';
import 'package:my_portfolio/data/repositories/personal_data_repo.dart';

import '../../data/firestore_services/portfolio_services.dart';

class PortfolioCubit extends Cubit<PortfolioStates> {
  PortfolioCubit() : super(PortfolioInitialStates()) ;
  static PortfolioCubit get(context) => BlocProvider.of(context) ;
  final PortfolioDataRepo portfolioDataRepo = PortfolioDataRepo(PortfolioFirebaseServices()) ;

  bool isDark = true;
  void switchTheme() {
    isDark =!isDark;
    emit(SwitchThemeState());
  }

  late ScreenSize screenSize ;
  void screenState(BoxConstraints constraints){
    screenSize = ScreenSize.isDesktop ;
    if(constraints.minWidth >= 1000){
      screenSize = ScreenSize.isDesktop ;
    }
    else if(constraints.minWidth >= 600 && constraints.minHeight >= 600 ){
      screenSize = ScreenSize.isTablet ;
    }else{
      screenSize = ScreenSize.isMobile ;
    }
    debugPrint(screenSize.toString());
  }

  late PersonalData personalData ;
  void getPersonalData(){
    portfolioDataRepo.getPersonalData().then((value){
      debugPrint('dataLoaded');
      personalData = value ;
        emit(PersonalDataLoaded());
      }).catchError((e){
        debugPrint('get user error $e') ;
        emit(PersonalDataLoadingError());
      });
    }

}