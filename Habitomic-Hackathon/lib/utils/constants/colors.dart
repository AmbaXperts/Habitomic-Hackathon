import 'package:flutter/material.dart';

class TColors{

  TColors._();


// App Basic Color
  static const Color primaryColor= Color.fromARGB(255, 174, 156, 211);
  static const Color secondaryColor= Color(0xFFFFE24B);
  static const Color accent= Color(0xFFb0c7ff);


// Gradiant color(not on the figma but in case we need to add gradiant for better UI)

static const Gradient linerGradiant = LinearGradient(
  begin: Alignment(0.0,0.0),
  end: Alignment(0.707, -0.707),
  
  colors: [
    Color.fromARGB(255, 58, 58, 58),
    Color(0xFFABAEBA),
    Color.fromARGB(255, 196, 217, 217),
  
]

);

  //Text Colors
 static const Color textprimery= Color(0xFF333333);
 static const Color textsecondary= Color(0xFF6c757D);
 static const Color textwhite= Colors.white;

 
  //Background Colors
 static const Color light= Color(0xFFF6F6F6);
 static const Color dark= Color(0xFF272727);
 static const Color primeryBackground= Color(0xFFF3F5FF);

   //Background Container Colors
 static const Color lightContainer= Color(0xFFF6F6F6);
static Color darkContainer = TColors.textwhite.withOpacity(0.1);// there is some issue here !!!!!!!!!!!!!!!!

//Button Color
 static const Color buttonPrimery= Color(0xFF6055D8);
 static const Color buttonSecondary= Color(0xFF6C7570);
 static const Color buttonDisabled= Color(0xFFC4C4C4);

 //border Color
 static const Color borderPrimery= Color(0xFFD9D9D9);
 static const Color borderSecondary= Color(0xFFE6E6E6);

//border Color
 static const Color error= Color(0xFFD32F2F);
 static const Color success= Color(0xFF388E3C);

 static const Color warning= Color(0xFFF57C00);
 static const Color info= Color(0xFF1976D2);

 //neutral shades
 static const Color black= Color(0xFF232323);
 static const Color darkerGrey= Color(0xFF4F4F4F);
 static const Color darkGrey= Color(0xFF939393);
 static const Color grey= Color(0xFFE0E0E0);
 static const Color softGrey= Color(0xFFF4F4F4);
 static const Color lightGrey= Color(0xFFF9F9F9);
 static const Color white= Color(0xFFFFFFFF);


}