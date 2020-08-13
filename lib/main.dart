import 'package:flutter/material.dart';
import 'package:growa_app/initial_page.dart';
import 'package:growa_app/loading_screen.dart';
import 'package:growa_app/splash_screen.dart';
import 'package:growa_app/stats_page.dart';
import 'login.dart';
import 'package:flutter/services.dart';
import 'overview_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white, //top bar color
    statusBarIconBrightness: Brightness.dark, //top bar icons
    systemNavigationBarColor: Colors.white, //bottom bar color
    systemNavigationBarIconBrightness: Brightness.dark, //bottom bar icons
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final routes = <String, WidgetBuilder>{
    InitialPage.tag: (context) => InitialPage(),
    Login.tag: (context) => Login(),
    LoadingScreen.tag: (context) => LoadingScreen(),
    OverviewPage.tag: (context) => OverviewPage(),
    SplashScreen.tag: (context) => SplashScreen(),
    StatsPage.tag: (context) => StatsPage(),
  };

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown]);
    return MaterialApp(
      title: 'Growa',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
        fontFamily: 'BebasNeue',
      ),
      home: LoadingScreen(),
      routes: routes,
    );
  }
}
