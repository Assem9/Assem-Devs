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

import '../../constants/my_colors.dart';

class ContactUsScreen extends StatelessWidget {
    ContactUsScreen({Key? key}) : super(key: key);

  final TextEditingController customerMessageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.dark,
      body: BlocBuilder<PortfolioCubit,PortfolioStates>(
          builder:(context,state){
            return Center(
              child: Container(
                height: PortfolioCubit.get(context).screenSize == ScreenSize.isMobile
                    ? 820 : MediaQuery.of(context).size.height ,
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: PortfolioCubit.get(context).screenSize == ScreenSize.isMobile ? 12 : 100
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildTextsColumn(context) ,
                      Flex(
                        direction: PortfolioCubit.get(context).screenSize == ScreenSize.isMobile
                            ? Axis.vertical
                            : Axis.horizontal,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(fit: FlexFit.loose, child: _buildContactsDataColumn(context)) ,
                          const SizedBox(width: 50,),
                          Flexible(fit: FlexFit.loose,child: _buildTextInputForm(context)) ,
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          ),
    );
  }
    Widget _buildTextsColumn(context){
      return SizedBox(
        // height: MediaQuery.of(context).size.height * 0.2,
        child: Column(
          children: [
            Text(
              'Assem Devs',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20,),
            Text(
              'Contact With Me:',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 20,),
          ],
        ),
      );

    }

  Widget _buildTextInputForm(context){
    var cubit =PortfolioCubit.get(context) ;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
         // height: MediaQuery.of(context).size.height/2,
          width: cubit.screenSize == ScreenSize.isMobile
              ? MediaQuery.of(context).size.width - 50
              : MediaQuery.of(context).size.width/2,
          child: DefaultTextField(
            controller: customerMessageController,
            hint: '     Write Your Request Here',
            type: TextInputType.text,
            maxLines: 5,
            border: InputBorder.none,
          ),
        ),
        DefaultButton(
            title: 'SEND',
            textColor: Colors.white,
            width: MediaQuery.of(context).size.width/2,
            onTap: (){}
        ),
      ],
    );
  }

  Widget _buildContactsDataColumn(context){
    var cubit =PortfolioCubit.get(context) ;
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        Align(
          alignment: AlignmentDirectional.bottomCenter,
          child: SvgPicture.asset(
            'assets/images/social_share.svg',//social_share.svg  //contact_us.svg
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width /2 ,
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
