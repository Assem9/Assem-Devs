import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_cubit.dart';
import 'package:my_portfolio/data/models/screen_size.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../business_logic/cubits/portfolio_states.dart';
import '../../utils/my_colors.dart';
import '../../utils/strings.dart';


class LayoutScreen extends StatelessWidget {
  LayoutScreen({super.key});
  final ItemScrollController _itemScrollController = ItemScrollController() ;

  final scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    PortfolioCubit cubit =PortfolioCubit.get(context);
    return BlocBuilder<PortfolioCubit, PortfolioStates>(
      buildWhen: (previous,current)=> current is ScreenSizeChanged,
      builder: (context, state) {
        //print('layout builder ${MediaQuery.of(context).size.width}') ;
        return MediaQuery(
            data: MediaQuery.of(context).copyWith(
              textScaleFactor:
              cubit.screenSize == ScreenSize.isMobile
                  ? 1
                  : cubit.screenSize == ScreenSize.isTablet
                  ? 1.2
                  : 1.5,
            ),
            child:  Scaffold(
              appBar: AppBar(
                title: cubit.screenSize == ScreenSize.isDesktop
                    ? const Text('Assem-Dev')
                    : null,
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
                itemCount: cubit.screens.length,
                itemScrollController: _itemScrollController,
                itemBuilder: (context , index) {
                  return  cubit.screens[index];
                },

              ),
              drawer: cubit.screenSize == ScreenSize.isMobile
                  ? _buildDrawer(context)
                  : null,
            )
        );
  },
);
  }

  Widget _buildAppBarButton({
    required String title,
    required int index,
    required context
  }){
    return Flexible(
      child: Container(
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
      ),
    );
  }

  Widget _buildDrawer(context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal:20 ,vertical: 20),
              color: MyColors.purple,
              width: double.infinity,
              height: 80,
              child: Text('Assem-Dev', style: Theme.of(context).textTheme.displayMedium,),
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
    );
  }
}
/// Hi there, my name is Assem Hassan and I'm computer science graduate from Misr University.
/// After completing my military service four months ago, I decided to focus on improving my skills in Flutter development.
/// During this time, I have been able to publish three apps on the Google Play Store,
/// one of which has a corresponding website and Windows application.
/// I have also developed a portfolio website to showcase my projects and skills.
/// I am excited to bring my passion for mobile app development
/// and my willingness to learn and grow to this internship opportunity.
/// Thank you for considering my application


/// Hello Again, my name is Assem Hassan.
/// I recently completed my military service and
/// am a graduate of Misr University, where I studied computer science.
/// During my time in the military, I developed a strong sense of discipline and teamwork,
/// which I believe will be valuable assets in any work environment. As a computer science graduate,
/// I have a solid foundation in programming, data structures, algorithms, and software engineering.
/// In addition to my academic background, I have a passion for mobile app development,
/// specifically using Flutter