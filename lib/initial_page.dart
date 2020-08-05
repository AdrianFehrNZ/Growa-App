import 'package:flutter/material.dart';
import 'package:growa_app/animated_tab_bar.dart';
import 'package:growa_app/main_drawer.dart';
import 'package:flutter/services.dart';
import 'package:growa_app/pageview_controller.dart';
import 'package:growa_app/stats_page.dart';

class InitialPage extends StatefulWidget {
  static String tag = 'InitialPage';

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage>
    with SingleTickerProviderStateMixin {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  final ValueNotifier<int> _notifier = ValueNotifier<int>(1);

  Route _createRoute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => StatsPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(1.0, -1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(
          CurveTween(curve: curve),
        );

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  tabCallback(int tab) {
    setState(() {
      print(tab.toString());
      this._notifier.value = tab;
    });

  }

  pageCallback(int page) {
    setState(() {
      this._notifier.value = page;
    });

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return WillPopScope(
      onWillPop: () {
        //trigger leaving and use own data
        if (!_scaffoldKey.currentState.isDrawerOpen) {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          return Future.value(false);
        }
        //we need to return a future
        return Future.value(true);
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          key: _scaffoldKey,
          drawer: MainDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Hero(
                    tag: 'heroHome',
                    child:
                        Image.asset('assets/logo.jpg', fit: BoxFit.scaleDown)),
                Text(
                  'GROWA',
                  style: TextStyle(
                    fontFamily: 'BebasNeue',
                    color: Color.fromRGBO(61, 8, 89, 100),
                  ),
                ),
              ],
            ),
            actions: <Widget>[
//              Hero(
//                tag: 'stats',
//                child: Material(
//                  color: Colors.transparent,
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(_createRoute());
                },
                splashColor: Colors.purple,
                icon: Icon(
                  Icons.assessment,
                  color: Color.fromRGBO(61, 8, 89, 100),
                ),
              ),
            ],
          ),
          body: ValueListenableBuilder<int>(
            builder: (context, value, child) {
              return PageViewController(_notifier, this.pageCallback);
            },
            valueListenable: _notifier,
          ),
          bottomNavigationBar: AnimatedTabBar(1, this.tabCallback),
        ),
      ),
    );
  }
}
