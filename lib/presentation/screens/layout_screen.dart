import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_cubit.dart';
import 'package:my_portfolio/data/models/screen_size.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../../constants/my_colors.dart';
import '../../constants/strings.dart';
import 'about_screen.dart';
import 'home_screen.dart';


class LayoutScreen extends StatelessWidget {
  LayoutScreen({super.key});
  final ItemScrollController _itemScrollController = ItemScrollController() ;

  Widget _buildAppBarButton({
    required String title,
    required int index,
    required context
  }){
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 14.0,vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: TextButton(
          onPressed: (){
            _itemScrollController.scrollTo(
                index: index,
                duration: const Duration(milliseconds: 500)
            );
            if(PortfolioCubit.get(context).screenSize == ScreenSize.isMobile) //to close the drawer
              Navigator.pop(context);
             },
          child: Text(
            title,
            style:  Theme.of(context).textTheme.bodyText2,
          )
      ),
    );
  }

  List<Widget> screens = [ const HomeScreen(),const AboutScreen() ];

  @override
  Widget build(BuildContext context) {
    print('width ${MediaQuery.of(context).size.width.toInt()}');
    print('height full ${(MediaQuery.of(context).size.height).toInt()}');
    PortfolioCubit cubit =PortfolioCubit.get(context);
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(
        textScaleFactor:
        cubit.screenSize == ScreenSize.isMobile ? 1 : 1.5,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('ASSEM DEVS'),
          actions:
          cubit.screenSize != ScreenSize.isMobile ? [
            _buildAppBarButton(title:'HOME', index: 0,context:context),
            _buildAppBarButton(title:'ABOUT', index: 1,context:context),
            _buildAppBarButton(title:'PROJECTS', index: 2,context:context),
            TextButton(
                onPressed: ()=> Navigator.pushNamed(context, contactUsScreen),
                child: Text(
                  'CONTACT US',
                  style:  Theme.of(context).textTheme.bodyMedium,
                )
            ),
          //_buildSwitchThemeButton(context),
          const SizedBox(width: 20,),
          ]: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                  onPressed: ()=> cubit.switchTheme(),
                  icon: Icon(Icons.brightness_4 , color: cubit.isDark? Colors.white :Colors.black,)
              ),
            ),
            const SizedBox(width: 20,),
          ],

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
      ),
    );
  }
  Widget _buildSwitchThemeButton(context){
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: IconButton(
          onPressed: ()=> PortfolioCubit.get(context).switchTheme(),
          icon: Icon(Icons.brightness_4 , color: PortfolioCubit.get(context).isDark? Colors.white :Colors.black,)
      ),
    );
  }

  Widget _buildDrawer(context) {
    return SafeArea(
      child: Drawer(
        child: Container(
          color: PortfolioCubit.get(context).isDark ? MyColors.dark: Colors.white,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal:20 ,vertical: 20),
                color: MyColors.orange,
                width: double.infinity,
                height: 80,
                child: Text('ASSEM', style: Theme.of(context).textTheme.displayLarge,),
              ),
              _buildAppBarButton(title:'HOME', index: 0,context:context),
              _buildAppBarButton(title:'ABOUT', index: 1,context:context),
              _buildAppBarButton(title:'PROJECTS   ', index: 2,context:context),
              _buildAppBarButton(title:'CONTACT', index: 3,context:context),
            ],
          ),
        ),
      ),
    );
  }
}