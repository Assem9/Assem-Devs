import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_states.dart';
import 'package:my_portfolio/data/models/personal_data.dart';
import 'package:my_portfolio/data/models/screen_size.dart';
import 'package:my_portfolio/data/repositories/personal_data_repo.dart';
import '../../presentation/screens/about_screen.dart';
import '../../presentation/screens/home_screen.dart';
import '../../presentation/screens/projects_screen.dart';

class PortfolioCubit extends Cubit<PortfolioStates> {
  PortfolioCubit(this.portfolioDataRepo) : super(PortfolioInitialStates()) ;
  static PortfolioCubit get(context) => BlocProvider.of(context) ;
  final PortfolioDataRepo portfolioDataRepo ;
  List<Widget> screens = [ const HomeScreen(),  AboutScreen(),   const ProjectsScreen() ];
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
    else if(constraints.minWidth >= 750 && constraints.minHeight >= 600 ){
      screenSize = ScreenSize.isTablet ;
    }else{
      screenSize = ScreenSize.isMobile ;
    }
    emit(ScreenSizeChanged());
   // debugPrint(screenSize.toString());
  }

  bool dataLoading = false ;
  late PersonalData personalData ;
  void getPersonalData(){
    dataLoading = true ;
    emit(DataLoading());
    portfolioDataRepo.getPersonalData().then((value){
      personalData = value ;
      dataLoading = false ;
        emit(PersonalDataLoaded());
      }).catchError((e){
        emit(PersonalDataLoadingError());
      });
    }

  void sendMessage(String msg)async{
    await portfolioDataRepo.createCustomerMessage(msg: msg).then((value) {
      emit(CustomerSentMessage());
    });
  }


}