import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_cubit.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_states.dart';
import 'package:my_portfolio/data/models/screen_size.dart';
import '../../constants/my_colors.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  /*
  ShaderMask(
          shaderCallback: (Rect bounds) {
            return  const LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.bottomLeft,
                colors: [
                  MyColors.white,
                  MyColors.orange,
                ]
            ).createShader(bounds);
          },
   */

  Color shadowColor(context) {
    if(PortfolioCubit.get(context).isDark) {
      return MyColors.darkBlack ;
    }else{
      return MyColors.darkWhite ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PortfolioCubit,PortfolioStates>(
      listener: (context, state){},
      builder: (context, state) {
        var cubit = PortfolioCubit.get(context);
        return Container(
          height: MediaQuery.of(context).size.height ,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Flex(
            direction: cubit.screenSize == ScreenSize.isMobile
                ? Axis.vertical
                : Axis.horizontal,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildHomeDataWidget(context),
              const SizedBox(height:10,),
              _buildImage(context),
            ],
          ),
        );
      },
    );
  }

  Widget _buildImage(context) {
    PortfolioCubit cubit = PortfolioCubit.get(context);
    return Expanded(
      flex: cubit.screenSize == ScreenSize.isMobile? 4:3,
        child: Flex(
          direction: cubit.screenSize == ScreenSize.isMobile
              ? Axis.horizontal
              : Axis.vertical,
        mainAxisAlignment:  MainAxisAlignment.center,
        children: [
          cubit.screenSize == ScreenSize.isMobile
              ? Expanded(flex: 1,child: Container())
              : Container(),
          const SizedBox(height: 50,),
          Expanded(
            flex: 5,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return  const LinearGradient(
                    begin: Alignment.bottomRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      MyColors.purple,
                      MyColors.white,
                      MyColors.purple,
                    ]
                ).createShader(bounds);
              },
              child: Container(
                decoration:  BoxDecoration(
                  border: Border.all(color: MyColors.purple,width: 2),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: MyColors.purple.withOpacity(0.5),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                   //shape: BoxShape.circle,
                 // color: Colors.white,
                  /*image: const DecorationImage(
                    image: AssetImage('assets/images/me222.jpeg'),
                    fit: BoxFit.contain,
                  ),*/

                ),
                 child: Image(
                  image:  AssetImage('assets/images/me222.jpeg'),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          cubit.screenSize != ScreenSize.isMobile
              ? Expanded(flex: 1,child: Container())
              : Container(),
        ],
      ),
    );
  }

  Widget _buildHomeDataWidget(context) {
    var cubit = PortfolioCubit.get(context);
    return Expanded(
      flex: 3,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: cubit.screenSize == ScreenSize.isMobile ? 20 : 40
        ),
        margin: EdgeInsets.only(
            top: cubit.screenSize == ScreenSize.isMobile ? 20 : 100
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _buildHelloBoxWidget(context),
            const SizedBox(height: 15,),
            AnimatedTextKit(
                repeatForever: false,
                pause: const Duration(seconds: 5),
                animatedTexts: [
                  ColorizeAnimatedText(
                      'ASSEM HASSAN',
                      textStyle: Theme.of(context).textTheme.displayMedium! ,
                      colors: [
                        MyColors.purple,
                        Colors.white,
                        MyColors.purple4,
                        MyColors.darkBlue
                      ]
                  ),
                ]
            ),
            const SizedBox(height: 15,),
            Text(
              'Mobile App Developer',
              style: Theme.of(context).textTheme.bodyLarge ,
            ),
            const SizedBox(height: 15,),
            _buildResumeButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHelloBoxWidget(context){
    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
         // color: MyColors.orange,
          borderRadius: const BorderRadius.only(topRight: Radius.circular(25), bottomLeft:Radius.circular(25), )
      ),
      child: AnimatedTextKit(
          repeatForever: true,
          animatedTexts: [
            TyperAnimatedText(
              'Hello, i\'m ',
              speed: Duration(milliseconds: 100)
            ),
          ]
      ),
    );
  }

  Widget _buildResumeButton(context){
    return Container(
      alignment: AlignmentDirectional.center,
      height: 35,
      width: 130,
      decoration: BoxDecoration(
          color: MyColors.purple,
          borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'RESUME ',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          Icon(
            Icons.download_outlined,
            color: PortfolioCubit.get(context).isDark? Colors.white : Colors.black,
            size: 17,
          )
        ],
      ),
    );
  }
}
