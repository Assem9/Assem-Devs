import 'package:flutter/material.dart';
import 'package:my_portfolio/presentation/screens/contact_us_screen.dart';

import '../constants/strings.dart';
import '../presentation/screens/layout_screen.dart';

class AppRouter{

  AppRouter(){}

  Route? generateRoute(RouteSettings settings){
    switch (settings.name){
      case home:
        return MaterialPageRoute(
          builder: (_) => LayoutScreen()
        );
      case contactUsScreen:
        return MaterialPageRoute(
            builder: (_) =>  ContactUsScreen()
        );
      default:
    }
    return null;
  }
}