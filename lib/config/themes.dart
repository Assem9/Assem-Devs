import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/utils/text_style.dart';
import '../utils/my_colors.dart';

ThemeData lightTheme = ThemeData(
  primarySwatch: Colors.blueGrey,
  iconTheme: const IconThemeData(color: Colors.white),
  scaffoldBackgroundColor: MyColors.darkWhite,
  appBarTheme: const AppBarTheme(
      systemOverlayStyle:SystemUiOverlayStyle(
          statusBarColor: Colors.grey,
          statusBarIconBrightness: Brightness.dark
      ) ,
      elevation: 0.0,
      backgroundColor: MyColors.appBarColor,
      iconTheme: IconThemeData(color: MyColors.orange)
  ),
  textTheme: TextTheme(
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    bodyLarge: bodyLarge ,
    bodyMedium: bodyMedium,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: titleSmall,
    bodySmall: bodySmall
  ),
);


ThemeData darkTheme = ThemeData(
  primarySwatch: Colors.deepOrange,
  iconTheme: const IconThemeData(color: Colors.white),
  scaffoldBackgroundColor: MyColors.appBarColor,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle:SystemUiOverlayStyle(
          statusBarColor: MyColors.darkBlack,
          statusBarIconBrightness: Brightness.dark
      ) ,
    elevation: 0.0,
    backgroundColor: MyColors.appBarColor,
    iconTheme: IconThemeData(color: MyColors.white),
  ),
  textTheme: TextTheme(
        displayMedium: displayMedium.copyWith(color: MyColors.white),
        displaySmall: displaySmall ,
        bodyLarge: bodyLarge.copyWith(color: MyColors.white) ,
        bodyMedium: bodyMedium.copyWith(color: MyColors.white),
        titleLarge: titleLarge.copyWith(color: MyColors.white),
        titleMedium: titleMedium.copyWith(color: MyColors.white),
        titleSmall: titleSmall.copyWith(color: MyColors.white),
        bodySmall: bodySmall.copyWith(color: MyColors.white)
    ),


);

//ThemeData setTheme(){}

