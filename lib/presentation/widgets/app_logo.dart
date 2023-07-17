import 'package:flutter/material.dart';
import '../../utils/my_colors.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({Key? key, required this.radius}) : super(key: key);
  final double radius ;
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: MyColors.purple,
      shadowColor: MyColors.darkBlue,
      elevation: 10,
      shape: BoxShape.circle,
      child: CircleAvatar(
          radius: radius , // MediaQuery.of(context).size.height/8,
          backgroundImage: const AssetImage('assets/images/logo.png',)
      ),
    );
  }
}
