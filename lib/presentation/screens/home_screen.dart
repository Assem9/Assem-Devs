import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_cubit.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_states.dart';
import 'package:my_portfolio/data/models/screen_size.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/my_colors.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height - (AppBar().preferredSize.height),
      width: double.infinity,
      //padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: const BoxDecoration(

      ),
      alignment: AlignmentDirectional.center,
      child: SizedBox(
        //width: MediaQuery.of(context).size.width * 0.8,
        child: Stack(
          children: [
            //BlendMode.color //colorDodge//hardLight
            //ColorFiltered(
            //               colorFilter: const ColorFilter.mode(MyColors.purple, BlendMode.hardLight),
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/home_background_effect.jpg'),
                    fit: BoxFit.cover
                ),
              ),
            ),
            Align(
              alignment: PortfolioCubit.get(context).screenSize ==ScreenSize.isMobile
                  ? AlignmentDirectional.bottomEnd
                  : AlignmentDirectional.centerEnd,
              child: _buildMyImageWidget(context),
            ),
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: _buildHomeDataWidget(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMyImageWidget(context){
    return BlocBuilder<PortfolioCubit, PortfolioStates>(
        buildWhen: (previous, current)=> current is ScreenSizeChanged,
        builder: (context, state) {
          //print('image builder');
        return Container(
          height:  MediaQuery.of(context).size.height/2,
          width: MediaQuery.of(context).size.height/2,
          alignment: AlignmentDirectional.centerEnd,
          margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
              vertical:10
          ) ,
          decoration:  BoxDecoration(
            color: MyColors.purple,
            shape: BoxShape.circle,
            border: Border.all(color: MyColors.purple,width: 2),
            image: const DecorationImage(
              image: AssetImage('assets/images/me222.jpeg'),
              fit: BoxFit.contain,
            ),
            boxShadow: [
              BoxShadow(
                color: MyColors.purple.withOpacity(0.7),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
        );
      }
    );
  }

  Widget _buildHomeDataWidget(context) {
    var cubit = PortfolioCubit.get(context);
    return Container(
      padding: EdgeInsets.only(
          top: cubit.screenSize == ScreenSize.isMobile ? 10 : 100
      ),
      margin: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1) ,
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
         // repeatForever: false,
          totalRepeatCount:2,
          //pause: const Duration(seconds: 2),
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
    return BlocBuilder<PortfolioCubit, PortfolioStates>(
      buildWhen: (previous,current)=> current is PersonalDataLoaded,
      builder: (context, state) {
        //print('_buildResumeButton');
        return !PortfolioCubit.get(context).dataLoading
        ? InkWell(
      onTap: ()async{
        var url = Uri.parse(PortfolioCubit.get(context).personalData.resume);
        await launchUrl(url,mode: LaunchMode.externalApplication);
        //await AdminRepository(AdminDataServices()).createNewProject();
      },
      child: Container(
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
      ),
    )
        :  Image.asset('assets/images/ballons_loader.gif');//Image.asset
  },
);
  }
}
