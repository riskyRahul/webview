import 'dart:io';

import 'package:flutter/material.dart';

const String openMenuFromRightToLeft = 'openMenuFromRightToLeft';

class Constant
{
  // static String bannerId = Platform.isAndroid
  //     ? 'ca-app-pub-3940256099942544/6300978111'
  //     : 'ca-app-pub-3940256099942544/6300978111';

  // static String interstitialId = Platform.isAndroid
  //     ? 'ca-app-pub-3940256099942544/1033173712'
  //     : 'ca-app-pub-3940256099942544/1033173712';


  /*static Color lightPrimary = Color(0xfff3f4f9);
  static Color darkPrimary = Color(0xff2B2B2B);
  static Color lightAccent = Color(0xff597ef7);
  static Color darkAccent = Color(0xff597ef7);*/
  static Color lightBG = Color(0xfff3f4f9);
  //static Color darkBG = Color(0xff2B2B2B);

  static Color cc=Color.fromARGB(255, 33, 66, 132);



  static Color myColor = Color(0xff214284);

  static Map<int, Color> myycolor =
  {
    50:Color.fromRGBO(255,33,132, .1),
    100:Color.fromRGBO(255,33,132, .2),
    200:Color.fromRGBO(255,33,132, .3),
    300:Color.fromRGBO(255,33,132, .4),
    400:Color.fromRGBO(255,33,132, .5),
    500:Color.fromRGBO(255,33,132, .6),
    600:Color.fromRGBO(255,33,132, .7),
    700:Color.fromRGBO(255,33,132, .8),
    800:Color.fromRGBO(255,33,132, .9),
    900:Color.fromRGBO(255,33,132, 1),
  };

  static MaterialColor colorCustom = MaterialColor(0xFF214284, myycolor);


  static ThemeData lightTheme = ThemeData(
    backgroundColor: lightBG,
    primaryColor: colorCustom,
    primarySwatch: colorCustom,
    accentColor:  colorCustom,
    cursorColor: colorCustom,
    scaffoldBackgroundColor: lightBG,
    appBarTheme: AppBarTheme(
      elevation: 0,
      textTheme: TextTheme(
        title: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    ),
  );
}