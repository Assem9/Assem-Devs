
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_portfolio/business_logic/cubits/admin_cubit/admin_cubit.dart';
import 'package:my_portfolio/business_logic/cubits/admin_cubit/admin_states.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_cubit.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_states.dart';
import 'package:my_portfolio/utils/my_colors.dart';
import 'package:my_portfolio/data/models/Project.dart';
import 'package:my_portfolio/data/models/screen_size.dart';
import 'package:my_portfolio/presentation/widgets/app_logo.dart';
import 'package:my_portfolio/presentation/widgets/default_button.dart';
import 'package:my_portfolio/presentation/widgets/textfield.dart';

import '../../utils/strings.dart';

class AdminScreen extends StatelessWidget {
  AdminScreen({Key? key}) : super(key: key);
  final TextEditingController textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(30.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    color: MyColors.purple,
                    padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                    child: Text(
                      'ADMIN PANEL',
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ),
                  const SizedBox(height: 15,),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        _buildPanelServicesBar(),
                        shownService(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget shownService(){
    return BlocBuilder<AdminCubit,AdminStates>(
        builder: (context,state){
          var cubit =AdminCubit.get(context) ;
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 20),
            width: MediaQuery.of(context).size.width -450,
            decoration: BoxDecoration(
              color: MyColors.dark,
              borderRadius: BorderRadius.circular(20),
            ),
            child: cubit.service == PanelServices.editPersonal
                ? personalDataFormFields(context)
                :  cubit.service == PanelServices.addProject
                ? _buildAddNewProjectWidget()
                : cubit.service == PanelServices.editProject
                ? _buildEditOldProjectForm()
                : Container(),
          );
        }
    );
  }

  Widget _buildPanelServicesBar(){
    return BlocBuilder<AdminCubit,AdminStates>(
      builder: (context,state) {
        return ShaderMask(
          shaderCallback: (Rect bounds) {
            return  const LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.bottomLeft,
                colors: [
                  MyColors.purple1 ,
                  MyColors.white,
                  MyColors.purple,
                ]
            ).createShader(bounds);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
            height: 600,
            width: 350,
            decoration: BoxDecoration(
              color: MyColors.purple,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                const AppLogoWidget(radius: 40),
                Container(
                  color: MyColors.purple,
                  padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 2),
                  child: Text(
                    'VISITS: 120',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                const SizedBox(height: 15,),
                DefaultButton(
                    title: 'Portfolio Data',
                    buttonColor: MyColors.white,
                    onTap: ()=>AdminCubit.get(context).changeShownPanelService(PanelServices.editPersonal)
                ),
                const SizedBox(height: 15,),
                DefaultButton(
                    title: 'Add Project',
                    buttonColor: MyColors.purple1,
                    onTap: ()=>AdminCubit.get(context).changeShownPanelService(PanelServices.addProject)
                ),
                const SizedBox(height: 15,),
                DefaultButton(
                    title: 'Edit Existing Project',
                    buttonColor: MyColors.purple1,
                    onTap: ()=>AdminCubit.get(context).changeShownPanelService(PanelServices.editPersonal)
                ),
                const SizedBox(height: 15,),
                DefaultButton(
                    title: 'Close Admin Panel',
                    buttonColor: Colors.red,
                    onTap: ()=> Navigator.pushNamedAndRemoveUntil(context, home, (route) => false)
                ),

              ],
            ),
          ),
        );
      }
    );
  }

  final TextEditingController aboutController = TextEditingController();
  final TextEditingController portfolioTitleController = TextEditingController();
  final TextEditingController resumeLinkController = TextEditingController();
  final TextEditingController whatsAppController = TextEditingController();
  final TextEditingController facebookController = TextEditingController();
  final TextEditingController gmailController = TextEditingController();


  Widget personalDataFormFields(context){
    return BlocBuilder<PortfolioCubit,PortfolioStates>(
      builder: (context,state) {
        //PersonalData personalData  = PortfolioCubit.get(context).personalData ;
        return !PortfolioCubit.get(context).dataLoading?
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildTextFieldWithTitle(
                context: context,
                title: 'ABOUT',
                value:  PortfolioCubit.get(context).personalData.aboutMeParagraph,
                controller: aboutController
            ),
            buildTextFieldWithTitle(
                context: context,
                title: 'Portfolio Title',
                value: PortfolioCubit.get(context).personalData.portfolioTitle,
                controller: portfolioTitleController
            ),
            buildTextFieldWithTitle(
                context: context,
                title: 'RESUME',
                value: PortfolioCubit.get(context).personalData.resume,
                controller: resumeLinkController
            ),
            buildTextFieldWithTitle(
                context: context,
                title: 'WHATSAPP',
                value: PortfolioCubit.get(context).personalData.whatsApp,
                controller: whatsAppController
            ),
            buildTextFieldWithTitle(
                context: context,
                title: 'GMAIL',
                value: PortfolioCubit.get(context).personalData.gmail,
                controller: gmailController
            ),
            buildTextFieldWithTitle(
                context: context,
                title: 'FACEBOOK',
                value: PortfolioCubit.get(context).personalData.facebook,
                controller: facebookController
            ),
            DefaultButton(
                title: 'SUBMIT CHANGES',
                textColor: Colors.white,
                onTap: (){}
            )

          ],
        ): const CircularProgressIndicator();
      }
    );
  }

  Widget buildTextFieldWithTitle({
    required BuildContext context,
    required String title,
    required String value,
    required TextEditingController controller,
  }){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,style: Theme.of(context).textTheme.bodyMedium,),
        const SizedBox(height: 10,),
        DefaultTextField(
          controller: controller,
          hint: value,
          border: InputBorder.none,
          type: TextInputType.text,
        ),
      ],
    );
  }


  Widget _buildAddNewProjectWidget(){
    return Container() ;
  }

  final TextEditingController apkLinkController = TextEditingController();
  final TextEditingController playStoreController = TextEditingController();
  final TextEditingController githubController = TextEditingController();
  final TextEditingController projectTitleController = TextEditingController();
  final TextEditingController projectDescriptionController = TextEditingController();
  Widget _buildAddNewProjectForm(context,Project project){
    return Column(
      children: [
        buildTextFieldWithTitle(
            context: context,
            title: 'TITLE',
            value: project.title ,
            controller: aboutController
        ),
        buildTextFieldWithTitle(
            context: context,
            title: 'DESCRIPTION',
            value: project.description ,
            controller: projectDescriptionController
        ),
        buildTextFieldWithTitle(
            context: context,
            title: 'GITHUB',
            value: project.gitHubLink ,
            controller: aboutController
        ),
        buildTextFieldWithTitle(
            context: context,
            title: 'PLAY STORE',
            value: project.gitHubLink ,
            controller: aboutController
        ),
      ],
    );
  }

  Widget _buildEditOldProjectForm(){
    return Column(
      children: [

      ],
    );
  }


  Widget _buildServiceWidget(context){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30,vertical: 10),
      height: 600,
      width: MediaQuery.of(context).size.width -450,
      decoration: BoxDecoration(
        color: MyColors.dark,
        borderRadius: BorderRadius.circular(20),
      ),
      child: GridView.builder(
        gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: PortfolioCubit.get(context).screenSize == ScreenSize.isDesktop? 2 : 1,
          childAspectRatio: 4/1 ,//3 /1.8
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
        ),
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        itemBuilder: (context, index)=> DefaultTextField(
          controller: textController,
          hint: '',
          type: TextInputType.text,
          border: InputBorder.none,
        ),
        itemCount: 6,
      ),
    );
  }

}
