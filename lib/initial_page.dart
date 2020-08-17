import 'package:flutter/material.dart';
import 'package:growa_app/main_drawer.dart';
import 'package:flutter/services.dart';
import 'package:growa_app/overview_page.dart';
import 'package:growa_app/produce_page.dart';
import 'package:growa_app/stats_page.dart';

class InitialPage extends StatefulWidget {
  static String tag = 'InitialPage';

  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage>
    with SingleTickerProviderStateMixin {
  final _scaffoldKey = new GlobalKey<ScaffoldState>();
  int _selectedIndex = 1;
  PageController _pageController;

  Route _statsRoute() {
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

  void _onItemTapped(int index) {
    setState(() {
      if (index - _selectedIndex > 1 || index - _selectedIndex < -1) {
        _selectedIndex = index;
        _pageController.jumpToPage(index);
      } else {
        _selectedIndex = index;
        _pageController.animateToPage(index,
            duration: Duration(milliseconds: 500), curve: Curves.easeOut);
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 1);
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
          systemNavigationBarColor: Colors.transparent,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          key: _scaffoldKey,
          drawer: MainDrawer(),
          appBar: AppBar(
            leading: Hero(
              tag: 'heroHome',
              child: IconButton(
                icon: Container(
                  child: Image(
                    image: AssetImage("assets/logo.jpg"),
                    color: null,
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.center,
                  ),
                ),
                onPressed: () => _scaffoldKey.currentState.openDrawer(),
              ),
            ),
            backgroundColor: Colors.white,
            centerTitle: true,
            title: Text(
              'GROWA',
              textScaleFactor: 1.75,
              style: TextStyle(
                fontFamily: 'BebasNeue',
                color: Color.fromRGBO(61, 8, 89, 100),
              ),
            ),
//              ],
//            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.of(context).push(_statsRoute());
                },
                icon: Icon(
                  Icons.assessment,
                  color: Color.fromRGBO(61, 8, 89, 100),
                ),
                highlightColor: Colors.white30,
              ),
            ],
          ),
          body: Center(
            child: PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() => _selectedIndex = index);
              },
              children: <Widget>[
                Container(
                  color: Colors.green,
                ),
                OverviewPage(),
                ProducePage(),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.6),
                  spreadRadius: 8,
                  blurRadius: 5,
                  offset: Offset(0, 7), // changes position of shadow
                ),
              ],
            ),
            child: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_basket),
                  title: Text('Marketplace'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Home'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.nature),
                  title: Text('Produce Planner'),
                ),
              ],
              currentIndex: _selectedIndex,
              unselectedFontSize: 0,
              selectedItemColor: Color.fromRGBO(61, 8, 89, 100),
              unselectedItemColor: Colors.grey,
              unselectedIconTheme: IconThemeData(size: 30),
              onTap: _onItemTapped,
              elevation: 25,
              type: BottomNavigationBarType.shifting,
            ),
          ),
        ),
      ),
    );
  }
}
