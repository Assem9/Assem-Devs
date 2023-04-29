import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_portfolio/constants/text_style.dart';
import '../constants/my_colors.dart';

ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: MyColors.darkWhite,
    appBarTheme: const AppBarTheme(
        systemOverlayStyle:SystemUiOverlayStyle(
            statusBarColor: Colors.grey,
            statusBarIconBrightness: Brightness.dark
        ) ,
        elevation: 0.0,
        backgroundColor: MyColors.darkWhite,
        iconTheme: IconThemeData(color: MyColors.orange)
    ),
    primarySwatch: Colors.blueGrey,
    iconTheme: const IconThemeData(color: MyColors.orange),
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: MyColors.white),

  textTheme: TextTheme(
    displayMedium: displayMedium,
    displaySmall: displaySmall,
    bodyLarge: bodyLarge ,
    bodyMedium: bodyMedium,
    titleLarge: titleLarge,
    titleMedium: titleMedium,
    titleSmall: GoogleFonts.aBeeZee(),
    bodySmall: bodySmall
  ),
);


ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.deepOrange,
    bottomSheetTheme: const BottomSheetThemeData(backgroundColor: MyColors.darkBlack),
    iconTheme: const IconThemeData(color: MyColors.white),
    scaffoldBackgroundColor: MyColors.darkBlack,
    appBarTheme: const AppBarTheme(
      // backwardsCompatibility: false, //to control status bar (Default =true)
      systemOverlayStyle:SystemUiOverlayStyle(
          statusBarColor: MyColors.darkBlack,
          statusBarIconBrightness: Brightness.dark
      ) ,
      elevation: 0.0,
      backgroundColor: MyColors.darkBlack,
      iconTheme: IconThemeData(color: MyColors.white),
    ),
    textTheme: TextTheme(
        displayMedium: displayMedium.copyWith(color: MyColors.white),
        displaySmall: displaySmall.copyWith(color: MyColors.white),
        bodyLarge: bodyLarge.copyWith(color: MyColors.white) ,
        bodyMedium: bodyMedium.copyWith(color: MyColors.white),
        titleLarge: titleLarge,
        titleMedium: titleMedium,
        titleSmall: GoogleFonts.aBeeZee().copyWith(color: MyColors.white),
        bodySmall: bodySmall.copyWith(color: MyColors.white)
    ),


);

//ThemeData setTheme(){}

