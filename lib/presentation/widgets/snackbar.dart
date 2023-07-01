import 'package:flutter/material.dart';
import 'package:my_portfolio/presentation/widgets/app_logo.dart';

SnackBar mySnack (context,String text){
  return SnackBar(
      content: Row(
        children: [
          const AppLogoWidget(radius: 20),
          const SizedBox(width: 30,),
          Expanded(child: Text(text,style: Theme.of(context).textTheme.bodyMedium,))
        ],
      )
  ) ;
}
