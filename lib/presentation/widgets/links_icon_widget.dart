import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:my_portfolio/business_logic/cubits/portfolio_cubit.dart';
import 'package:my_portfolio/data/models/screen_size.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/models/Project.dart';

class LinkIconButton extends StatelessWidget {
  const LinkIconButton({Key? key,required this.project}) : super(key: key);
  final Project project ;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        project.gitHubLink.isNotEmpty ?
        InkWell(
            onTap: ()async{
              var url = Uri.parse(project.gitHubLink);
              await launchUrl(url,mode: LaunchMode.externalApplication);
            },
            child: _buildIconWidget(context: context, title: 'GitHub', icon: MdiIcons.github)
        ) : Container(),
        const SizedBox(width:8,),
        project.playStoreLink.isNotEmpty ?
        InkWell(
            onTap: ()async{
              var url = Uri.parse(project.playStoreLink);
              await launchUrl(url,mode: LaunchMode.externalApplication);
            },
            child: _buildIconWidget(context: context, title: 'Playstore', icon: MdiIcons.googlePlay)
        ) : Container(),
        const SizedBox(width:8,),
        project.apkLink.isNotEmpty ?
        InkWell(
            onTap: ()async{
              var url = Uri.parse(project.apkLink);
              await launchUrl(url,mode: LaunchMode.externalApplication);
            },
            child:_buildIconWidget(context: context, title: 'Website', icon: MdiIcons.web)

        ) : Container(),
      ],
    );
  }


  Widget _buildIconWidget({required context,required String title, required IconData icon}){
    return Icon(
      icon,
      size: PortfolioCubit.get(context).screenSize == ScreenSize.isMobile
          ? MediaQuery.of(context).size.width/18
          : MediaQuery.of(context).size.width/40,
    );
  }
}
