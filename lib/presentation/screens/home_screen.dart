import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_cubit.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_states.dart';
import 'package:my_portfolio/data/models/screen_size.dart';
import '../../constants/my_colors.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
        return Container(
          height: MediaQuery.of(context).size.height ,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: _buildImage(context)
              ),
              Align(
                  alignment: AlignmentDirectional.topStart,
                  child: _buildHomeDataWidget(context)
              ),

            ],
          ),
        );
      },
    );
  }

  Widget _buildImage(context) {
    PortfolioCubit cubit = PortfolioCubit.get(context);
    return ShaderMask(
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
          height: cubit.screenSize == ScreenSize.isMobile
              ? MediaQuery.of(context).size.height * (2/3)
              : MediaQuery.of(context).size.height,
          width: cubit.screenSize == ScreenSize.isDesktop
              ? MediaQuery.of(context).size.width
              : MediaQuery.of(context).size.width * (2/3),
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
          ),
          child: const Align(
            alignment: AlignmentDirectional.centerEnd,
            child: Image(
              image: AssetImage('assets/images/me222.jpeg'),
              fit: BoxFit.contain,
            )
          ),
        ),
      );
  }

  Widget _buildHomeDataWidget(context) {
    var cubit = PortfolioCubit.get(context);
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: cubit.screenSize == ScreenSize.isMobile ? 20 : 40
      ),
      margin: EdgeInsets.only(
          top: cubit.screenSize == ScreenSize.isMobile ? 10 : 100
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          _buildHelloBoxWidget(context),
          const SizedBox(height: 15,),
          Text(
            'ASSEM HASSAN',
            style: Theme.of(context).textTheme.displayMedium ,
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
              speed: const Duration(milliseconds: 100)
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
