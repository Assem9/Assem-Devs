import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_cubit.dart';
import 'package:my_portfolio/data/models/screen_size.dart';
import 'package:my_portfolio/presentation/screens/projects_screen.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../business_logic/cubits/portfolio_states.dart';
import '../../constants/my_colors.dart';
import '../../constants/strings.dart';
import 'about_screen.dart';
import 'home_screen.dart';


class LayoutScreen extends StatelessWidget {
  LayoutScreen({super.key});
  final ItemScrollController _itemScrollController = ItemScrollController() ;


  List<Widget> screens = [ const HomeScreen(),  AboutScreen(),   ProjectsScreen() ];

  @override
  Widget build(BuildContext context) {
    print('width ${MediaQuery.of(context).size.width.toInt()}');
    print('height full ${(MediaQuery.of(context).size.height).toInt()}');
    PortfolioCubit cubit =PortfolioCubit.get(context);
    return BlocBuilder<PortfolioCubit,PortfolioStates>(
        builder: (context,state) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor:
            cubit.screenSize == ScreenSize.isMobile ? 1 : 1.5,
          ),
          child: !PortfolioCubit.get(context).dataLoading ?
          Scaffold(
            appBar: AppBar(
              title: cubit.screenSize == ScreenSize.isDesktop ? const Text('ASSEM DEVS') : null,
              actions:
              cubit.screenSize != ScreenSize.isMobile ? [
                _buildAppBarButton(title:'HOME', index: 0,context:context),
                _buildAppBarButton(title:'ABOUT', index: 1,context:context),
                _buildAppBarButton(title:'PROJECTS', index: 2,context:context),
                TextButton(
                    onPressed: ()=> Navigator.pushNamed(context, contactUsScreen),
                    child: Text(
                      'CONTACT ME',
                      style:  Theme.of(context).textTheme.bodyMedium,
                    )
                ),
                const SizedBox(width: 20,),
              ]: [],

            ),
            body: ScrollablePositionedList.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: screens.length,
              itemScrollController: _itemScrollController,
              itemBuilder: (context , index) {
                return screens[index];
              },

            ),
            drawer: cubit.screenSize == ScreenSize.isMobile
                ? _buildDrawer(context)
                : null,
          )
              :const Center(child: CircularProgressIndicator(),)
        );
      }
    );
  }

  Widget _buildAppBarButton({
    required String title,
    required int index,
    required context
  }){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14.0,vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: TextButton(
          onPressed: ()async{
            await _itemScrollController.scrollTo(
                index: index,
                duration: const Duration(milliseconds: 500)
            ).then((value){
              if(PortfolioCubit.get(context).screenSize == ScreenSize.isMobile) {
                Navigator.pop(context);
              }//to close the drawer
            });
          },
          child: Text(
            title,
            overflow: TextOverflow.clip,
            style:  Theme.of(context).textTheme.bodyMedium,
          )
      ),
    );
  }

  Widget _buildSwitchThemeButton(context){
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: IconButton(
          onPressed: ()=> PortfolioCubit.get(context).switchTheme(),
          icon: Icon(
            Icons.brightness_4 ,
            color: PortfolioCubit.get(context).isDark? Colors.white :Colors.black,
          )
      ),
    );
  }

  Widget _buildDrawer(context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          color: PortfolioCubit.get(context).isDark ? MyColors.darkBlack: Colors.white,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal:20 ,vertical: 20),
                color: MyColors.purple,
                width: double.infinity,
                height: 80,
                child: Text('Assem Devs', style: Theme.of(context).textTheme.displayMedium,),
              ),
              _buildAppBarButton(title:'HOME', index: 0,context:context),
              _buildAppBarButton(title:'ABOUT', index: 1,context:context),
              _buildAppBarButton(title:'PROJECTS', index: 2,context:context),
              TextButton(
                  onPressed: ()=> Navigator.pushNamed(context, contactUsScreen),
                  child: Text(
                    'CONTACT ME',
                    style:  Theme.of(context).textTheme.bodyMedium,
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }
}