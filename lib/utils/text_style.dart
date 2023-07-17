import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'my_colors.dart';

TextStyle displayMedium = GoogleFonts.montserrat(
  textStyle: const TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.w900,
    color: Colors.white,
  ),
  //Theme.of(context).textTheme.displaySmall,
);

TextStyle displaySmall = GoogleFonts.montserrat(
    textStyle: const TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        color: MyColors.purple,
    )
);

TextStyle titleLarge = GoogleFonts.montserrat(
    textStyle: const TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.w900,
        color: MyColors.purple
    )
) ;

TextStyle titleMedium = GoogleFonts.openSans(
    textStyle: const TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w900,
      color: MyColors.purple,
    )
);

TextStyle titleSmall = GoogleFonts.openSans(
    textStyle: const TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.bold,
      color: MyColors.purple,
    )
);

TextStyle bodyLarge = GoogleFonts.nunito(
  textStyle: const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  ),
);

TextStyle bodyMedium = GoogleFonts.openSans(
    textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Colors.black54,
    )
);

TextStyle bodySmall = GoogleFonts.openSans(
    textStyle: const TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.bold,
      color: Colors.black54,
    )
);

TextStyle appBarTitleStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: MyColors.white
);

/*


    bodyText2: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: MyColors.darkWhite
    ),
 */