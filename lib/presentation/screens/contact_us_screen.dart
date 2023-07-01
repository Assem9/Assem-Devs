import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_cubit.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_states.dart';
import 'package:my_portfolio/data/models/screen_size.dart';
import 'package:my_portfolio/presentation/widgets/default_button.dart';
import 'package:my_portfolio/presentation/widgets/show_toast.dart';
import 'package:my_portfolio/presentation/widgets/textfield.dart';

import '../../constants/my_colors.dart';
import '../widgets/snackbar.dart';

class ContactUsScreen extends StatelessWidget {
    ContactUsScreen({Key? key}) : super(key: key);

  final TextEditingController customerMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.black2,
      body: BlocBuilder<PortfolioCubit,PortfolioStates>(
          builder:(context,state){
            return !PortfolioCubit.get(context).dataLoading?
            Container(
              height: PortfolioCubit.get(context).screenSize == ScreenSize.isMobile
                  ? 820 : MediaQuery.of(context).size.height ,
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: PortfolioCubit.get(context).screenSize == ScreenSize.isDesktop ? 100 : 12
              ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Flex(
                        direction: PortfolioCubit.get(context).screenSize == ScreenSize.isMobile
                            ? Axis.vertical
                            : Axis.horizontal,
                        mainAxisSize: MainAxisSize.min,
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(fit: FlexFit.loose,child: _buildTextInputForm(context)) ,
                          const SizedBox(width: 50,),
                          const SizedBox(height: 20,),
                          Flexible(fit: FlexFit.loose, child: _buildContactsDataColumn(context)) ,
                        ],
                      ),
                    ],
                  ),
                ),
              )
                : const Center(child: CircularProgressIndicator(),);
          }
          ),
    );
  }
  Widget _buildTextsColumn(context){
      return Column(
        children: [
          const SizedBox(height: 30,),
          Container(
            color: MyColors.purple,
            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
            child: DefaultTextStyle(
              style:Theme.of(context).textTheme.displaySmall!.copyWith(fontSize: 50,color: MyColors.white) ,
              child: AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    WavyAnimatedText(PortfolioCubit.get(context).personalData.portfolioTitle,),
                  ]
              ),
            ),
          ),

          const SizedBox(height: 20,),
          Text(
            'Contact With Me:',
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 20,),
        ],
      );

    }

  final formKey = GlobalKey<FormState>();
  Widget _buildTextInputForm(context){
    var cubit =PortfolioCubit.get(context) ;
    //send_letter.svg
    return BlocListener<PortfolioCubit,PortfolioStates>(
      listener: (BuildContext context, state) {
        if(state is CustomerSentMessage){
          ScaffoldMessenger.of(context).showSnackBar(
              mySnack(context, 'your message has been sent successfully')
          );
          customerMessageController.text= '';
        }
      },
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Align(
            alignment: AlignmentDirectional.topEnd,
            child: SvgPicture.asset(
              'assets/images/send_letter.svg',
            ),
          ),
          Align(
            alignment: AlignmentDirectional.bottomStart,
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [

                  SizedBox(
                    width: cubit.screenSize == ScreenSize.isMobile
                        ? MediaQuery.of(context).size.width - 50
                        : MediaQuery.of(context).size.width/2,
                    child: DefaultTextField(
                      controller: customerMessageController,
                      hint: '   Write Your Request Here',
                      type: TextInputType.text,
                      maxLines: 5,
                      border: InputBorder.none,
                    ),
                  ),
                  DefaultButton(
                      title: 'SEND',
                      textColor: Colors.white,
                      width: MediaQuery.of(context).size.width/2,
                      onTap: (){
                        if(formKey.currentState!.validate()){
                          cubit.sendMessage(customerMessageController.text) ;
                        }
                      }
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            //alignment: AlignmentDirectional.topCenter,
            child: _buildTextsColumn(context),
          )
        ],
      ),
    );
  }

  Widget _buildContactsDataColumn(context){
    var cubit =PortfolioCubit.get(context) ;
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        /*
        Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: SvgPicture.asset(
            'assets/images/social_share.svg',//social_share.svg  //contact_us.svg
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width /2 ,
          ),
        ),*/
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 30,),
            _buildSocialDataField(
                context,
                icon: Icons.facebook,
                title: cubit.personalData.facebook,
            ),
            const SizedBox(height: 10,),
            _buildSocialDataField(
              context,
              icon: MdiIcons.google,
              title: cubit.personalData.gmail,
            ),
            const SizedBox(height: 10,),
            _buildSocialDataField(
              context,
              icon: MdiIcons.whatsapp,
              title: cubit.personalData.whatsApp,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialDataField(context,{
    required IconData icon ,
    required String title
  }){

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
      decoration: BoxDecoration(
        color: MyColors.darkBlack,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: MyColors.purple),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: MyColors.purple,
          ),
          Expanded(
            child: TextButton(
                onPressed: (){},
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                )
            ),
          ),
          IconButton(
            onPressed:(){
              Clipboard.setData(ClipboardData(text: title));
              ScaffoldMessenger.of(context).showSnackBar(
                  mySnack(context, 'Copied')
              );
            },
            icon: const Icon(
              Icons.copy,
              color: MyColors.purple,
            ),
          ),
        ],
      ),
    );
  }

}
