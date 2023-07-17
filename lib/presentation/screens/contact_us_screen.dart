
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_cubit.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_states.dart';
import 'package:my_portfolio/data/models/screen_size.dart';
import 'package:my_portfolio/presentation/widgets/default_button.dart';
import 'package:my_portfolio/presentation/widgets/textfield.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/my_colors.dart';
import '../widgets/snackbar.dart';

class ContactUsScreen extends StatelessWidget {
    ContactUsScreen({Key? key}) : super(key: key);

  final TextEditingController customerMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PortfolioCubit,PortfolioStates>(
          builder:(context,state){
            return !PortfolioCubit.get(context).dataLoading?
            Center(
              child: Container(
                height:  MediaQuery.of(context).size.height ,
                width: PortfolioCubit.get(context).screenSize == ScreenSize.isMobile
                    ? MediaQuery.of(context).size.width * 0.95
                    : MediaQuery.of(context).size.width * 0.8 ,
                  alignment: AlignmentDirectional.center,
                  child: SingleChildScrollView(
                    child: _buildTextInputForm(context),
                  ),
                ),
            )
                : const Center(child: CircularProgressIndicator(),);
          }
          ),
    );
  }
  Widget _buildTextsColumn(context){
      return Container(
        color: MyColors.purple,
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
        child: Text(
          'Contact With Me:',
          style: Theme.of(context).textTheme.displayMedium,
        ),
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
          ),
          Positioned(
              top: 100,
              left: 20,
              child: _buildContactsDataColumn(context)
          ),
        ],
      ),
    );
  }

  Widget _buildContactsDataColumn(context){
    var cubit =PortfolioCubit.get(context) ;
    return SizedBox(
      width:  PortfolioCubit.get(context).screenSize == ScreenSize.isMobile
          ? MediaQuery.of(context).size.width* 0.8
          :MediaQuery.of(context).size.width/2,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 30,),
          _buildSocialDataField(
            context,
            icon: MdiIcons.linkedin,
            title: cubit.personalData.linkedin,
          ),
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
    );
  }

  Widget _buildSocialDataField(context,{
    required IconData icon ,
    required String title
  }){

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
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
                onPressed: ()async{
                  var url = Uri.parse(title);
                  if(title.contains('@gmail.com')){
                    String subject = 'Contact From Portfolio Site';
                    String body = 'hello.... ';
                    var gmailUrl = Uri.parse('mailto:$title?subject=$subject&body=$body');
                    await launchUrl(gmailUrl,mode: LaunchMode.externalApplication);
                  }else if(title.startsWith('+2')){
                    var whatsAppUrl =Uri.parse('https://wa.me/$title' );
                    await launchUrl(whatsAppUrl,mode: LaunchMode.externalApplication);
                  }else{
                    await launchUrl(url,mode: LaunchMode.externalApplication);
                  }

                },
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
