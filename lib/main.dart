
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_cubit.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_states.dart';
import 'package:my_portfolio/config/themes.dart';
import 'business_logic/bloc_observer.dart';
import 'config/app_router.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
        apiKey: "AIzaSyAcrkL7P0UyfVbmOE6G-SOKpPDNOAsxpvM",
        appId: "1:988062904177:web:f0b74dc0f8378598aed0d0",
        messagingSenderId: "988062904177",
        projectId: "assem-devs"
    )
  );
  runApp( MyApp(appRouter: AppRouter(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.appRouter});
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> PortfolioCubit()..getPersonalData(),
      child: LayoutBuilder(
        builder: (context,BoxConstraints constraints) {
          PortfolioCubit.get(context).screenState(constraints);
          return BlocBuilder<PortfolioCubit, PortfolioStates>(
            builder: (context,state) {
              return MaterialApp(
                  debugShowCheckedModeBanner: false,
                  title: 'Assem Devs',
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  themeMode: PortfolioCubit.get(context).isDark? ThemeMode.dark : ThemeMode.light,
                  onGenerateRoute: appRouter.generateRoute,
                  //home: LayoutScreen()
              );
            }
          );
        }
      ),
    );
  }
}
