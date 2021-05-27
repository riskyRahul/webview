import 'dart:async';
import 'package:flutter/material.dart';

import 'home.dart';

class SplashScreen extends StatefulWidget
{
  static const String routeName = "/splash";
  @override
  SplashScreenState createState() => SplashScreenState();
}


class SplashScreenState extends State<SplashScreen>
{
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }


  @override
  void initState() {
    super.initState();
    startTime();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: new BoxDecoration(color: Colors.white),
          child: Center(
            child:Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                //CircularProgressIndicator(),
                //SizedBox(height: 100.0),
                /*FlutterLogo(
                  size: 100.0,
                  //colors: Colors.blue,
                ),
                SizedBox(height: 25.0),*/
                Image(
                  image:AssetImage("assets/app_logo.png"),
                    height: 250,
                    width: 250,
                ),
                SizedBox(height: 10.0),
                Text("",style: TextStyle(fontSize: 24,letterSpacing: 2,fontWeight: FontWeight.bold,color: Colors.black),)
              ])
          )),
      // Text("Splash Screen") 
    );
  }
}