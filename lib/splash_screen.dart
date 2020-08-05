import 'dart:async';
import 'package:flutter/material.dart';
import 'package:growa_app/login.dart';

class SplashScreen extends StatefulWidget {
  static String tag = 'SplashScreen';

  @override
  _SplashScreenState createState() => new _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  startTime() async {
    var _duration = new Duration(seconds: 2);
    return new Timer(_duration, navigationPage);
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Image.asset('assets/love.gif', height:125.0, width: 125.0,),
      ),
    );
  }

  void navigationPage() {
    Navigator.of(context).pushNamed(Login.tag);
  }

  void initState() {
    super.initState();
    startTime();
  }
}
