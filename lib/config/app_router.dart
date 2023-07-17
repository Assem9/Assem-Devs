import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/business_logic/cubits/admin_cubit/admin_cubit.dart';
import 'package:my_portfolio/business_logic/cubits/projects_cubit/projects_cubit.dart';
import 'package:my_portfolio/data/models/Project.dart';
import 'package:my_portfolio/presentation/screens/admin_login_screen.dart';
import 'package:my_portfolio/presentation/screens/admin_panel_screen.dart';
import 'package:my_portfolio/presentation/screens/contact_us_screen.dart';
import '../utils/strings.dart';
import '../presentation/screens/layout_screen.dart';
import '../presentation/screens/project_details_screen.dart';

class AppRouter {
  late AdminCubit adminCubit ;
  AppRouter(){
    adminCubit = AdminCubit();
  }

  Route<dynamic> generateRouteWithTransition(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return _getPageRoute(LayoutScreen(), settings);
      case admin :
        return _getPageRoute(
            BlocProvider.value(
                value: adminCubit,
                child: AdminLogInScreen()
            ),settings
        );
      case adminPanelScreen:
        return _getPageRoute(
            BlocProvider.value(
                value: adminCubit,
                child: AdminScreen()
        ), settings);
      case contactUsScreen:
        return _getPageRoute(ContactUsScreen(), settings);
      case dominoProject:
        Project? project = settings.arguments as Project? ;
        return  _getPageRoute(
            BlocProvider.value(
              value: ProjectsCubit(),
              child:  ProjectDetailsScreen(
                project: project,
                projectId: dominoProject,
              ),
            ), settings);
      case taskeuProject:
        return _getPageRoute(
            BlocProvider.value(
              value: ProjectsCubit(),
              child: const ProjectDetailsScreen(
                project: null,
                projectId: taskeuProject,
              ),
            ), settings);
      case mockMateProject:
        return _getPageRoute(
            BlocProvider.value(
              value: ProjectsCubit(),
              child: const ProjectDetailsScreen(
                project: null,
                projectId: mockMateProject,
              ),
            ), settings);
      default:
    }

    // If there is no such named route in the switch statement, e.g. /unknown,
    // then this will be executed.
    return _getPageRoute(LayoutScreen(), settings);
  }

  PageRouteBuilder _getPageRoute(Widget child, RouteSettings settings) {
    return PageRouteBuilder(
      settings: settings,
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return child;
      },
      transitionsBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

}