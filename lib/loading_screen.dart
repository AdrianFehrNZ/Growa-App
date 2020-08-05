import 'package:flutter/material.dart';

class LoadingScreen extends StatefulWidget {
  static String tag = 'LoadingScreen';
  @override
  _LoadingScreenState createState() => new _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 2),
    )..addListener(() => setState(() {}));
    animation = CurvedAnimation(
      parent: animationController,
      curve: Curves.easeInOut,
    );
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      alignment: Alignment.center,
      color: Colors.white,
      child: new AnimatedBuilder(
        animation: animationController,
        child: new Container(
          height: 150.0,
          width: 150.0,
          child: new Image.asset('assets/logo.jpg'),
        ),
        builder: (BuildContext context, Widget _widget) {
          return new ScaleTransition(
            scale: animation,
            child: _widget,
          );
        },
      ),
    );
  }
}
