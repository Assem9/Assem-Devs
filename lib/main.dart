import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_cubit.dart';
import 'package:my_portfolio/config/themes.dart';
import 'package:my_portfolio/utils/firebase_initialization.dart';
import 'package:url_strategy/url_strategy.dart';
import 'config/app_router.dart';
import 'data/firestore_services/portfolio_services.dart';
import 'data/repositories/personal_data_repo.dart';

//flutter run --web-renderer html

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  setPathUrlStrategy();
  //Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: FirebaseInitialization.appKey,
        appId: FirebaseInitialization.appId,
        messagingSenderId: FirebaseInitialization.messagingSenderId,
        projectId:FirebaseInitialization.projectId,
    )
  );
  runApp(  MyApp( appRouter: AppRouter(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter });
  final AppRouter appRouter ;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> PortfolioCubit(PortfolioDataRepo(PortfolioFirebaseServices()))..getPersonalData(),
      child: LayoutBuilder(
        builder: (context,BoxConstraints constraints) {
          PortfolioCubit.get(context).screenState(constraints);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Assem-Dev',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: ThemeMode.dark,
            onGenerateRoute: appRouter.generateRouteWithTransition,
            //home: LayoutScreen()
          );
        }
      ),
    );
  }
}
