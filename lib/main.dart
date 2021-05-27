import 'package:flutter/material.dart';

import 'Utils/constant.dart';

import 'home.dart';
import 'splash.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OSHO',
      theme: Constant.lightTheme,// define your theme
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        HomeScreen.routeName: (BuildContext context) => HomeScreen(),
      }
    );
  }
}