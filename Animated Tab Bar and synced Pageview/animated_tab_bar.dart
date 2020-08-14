import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'file:///D:/Documents/GitHub/GROWA/Animated%20Tab%20Bar%20and%20synced%20Pageview/tab_item.dart';
import 'package:vector_math/vector_math.dart' as vector;

class AnimatedTabBar extends StatefulWidget {
  AnimatedTabBar(this.currentSelected, this.callback);
  Function(int) callback;
  int currentSelected;


  @override
  _AnimatedTabBarState createState() => _AnimatedTabBarState();
}

class _AnimatedTabBarState extends State<AnimatedTabBar>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Tween<double> _positionTween;
  Animation<double> _positionAnimation;

  AnimationController _fadeOutController;
  Animation<double> _fadeOutAnimation;
  Animation<double> _fadeInAnimation;

  double tabIconAlpha = 1.0;
  IconData nextIcon = Icons.search;
  IconData activeIcon = Icons.search;
  int currentSelected = 1;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: ANIM_DURATION));

    _fadeOutController = AnimationController(
        vsync: this, duration: Duration(milliseconds: ANIM_DURATION ~/ 5));

    _positionTween = Tween<double>(begin: 0.0, end: 0.0);

    _positionAnimation = _positionTween.animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {});
      });

    _fadeOutAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(parent: _fadeOutController, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {
          tabIconAlpha = _fadeOutAnimation.value;
        });
      })
      ..addStatusListener((AnimationStatus status) {
        if (status == AnimationStatus.completed) {
          setState(() {
            activeIcon = nextIcon;
          });
        }
      });

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeOut))
      ..addListener(() {
        setState(() {
          tabIconAlpha = _fadeInAnimation.value;
        });
      });
  }

  initAnimationAndStart(double from, double to) {
    _positionTween.begin = from;
    _positionTween.end = to;
    _animationController.reset();
    _fadeOutController.reset();
    _animationController.forward();
    _fadeOutController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        Container(
          height: 40.0,
//          margin: EdgeInsets.only(top: 45.0),
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                color: Colors.blueGrey,
                offset: Offset(0.0, -1.0),
                blurRadius: 3.0),
          ]),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TabItem(
                selected: currentSelected == 0,
                iconData: Icons.looks_one,
                title: 'ONE',
                callbackFunction: () {
                  setState(() {
                    nextIcon = Icons.looks_one;
                    currentSelected = 0;
//                    widget.callback(currentSelected);
                  });
                  initAnimationAndStart(_positionAnimation.value, -1.0);
                },
              ),
              TabItem(
                selected: currentSelected == 1,
                iconData: Icons.home,
                title: 'HOME',
                callbackFunction: () {
                  setState(() {
                    nextIcon = Icons.home;
                    currentSelected = 1;
//                    widget.callback(currentSelected);
                  });
                  initAnimationAndStart(_positionAnimation.value, 0.0);
                },
              ),
              TabItem(
                selected: currentSelected == 2,
                iconData: Icons.looks_two,
                title: 'TWO',
                callbackFunction: () {
                  setState(() {
                    nextIcon = Icons.looks_two;
                    currentSelected = 2;
                    Navigator.push(context, route)
//                    widget.callback(currentSelected);
                  });
                  initAnimationAndStart(_positionAnimation.value, 1.0);
                },
              ),
            ],
          ),
        ),
        IgnorePointer(
          child: Container(
            decoration: BoxDecoration(color: Colors.transparent),
            child: Align(
              heightFactor: 0.0,
              alignment: Alignment(_positionAnimation.value, 0.0),
              child: FractionallySizedBox(
                widthFactor: 1 / 3.5,
                child: Stack(
                  alignment: Alignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 70.0,
                      width: 70.0,
                      child: ClipRect(
                        clipper: HalfClipper(),
                        child: Container(
                          child: Center(
                            child: Container(
                              width: 50.0,
                              height: 50.0,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.black, blurRadius: 8.0)
                                  ]),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 70.0,
                      height: 70.0,
                      child: CustomPaint(
                        painter: HalfPainter(),
                      ),
                    ),
                    SizedBox(
                      height: 35.0,
                      width: 35.0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromRGBO(61, 8, 89, 100),
//                          border: Border.all(
//                              color: Colors.white,
//                              width: 5.0,
//                              style: BorderStyle.none),
                        ),
//                        child: Padding(
//                          padding: const EdgeInsets.all(0.0),
                        child: Opacity(
                          opacity: tabIconAlpha,
                          child: Icon(
                            activeIcon,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class HalfClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    final rect = Rect.fromLTWH(0.0, 0.0, size.width, size.height / 2);
    return rect;
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

class HalfPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Rect beforeRect =
        Rect.fromLTWH(0.0, (size.height / 2) - 10, 10.0, 10.0);
    final Rect largeRect = Rect.fromLTWH(10.0, 10.0, size.width - 20, 45.0);
    final Rect afterRect =
        Rect.fromLTWH(size.width - 10, (size.height / 2) - 10, 10.0, 10.0);

    final path = Path();
    path.arcTo(beforeRect, vector.radians(0.0), vector.radians(90.0), false);
    path.lineTo(20.0, size.height / 2);
    path.arcTo(largeRect, vector.radians(0.0), -vector.radians(180.0), false);
    path.moveTo(size.width - 10, size.height / 2);
    path.lineTo(size.width - 10, (size.height / 2) - 10);
    path.arcTo(afterRect, vector.radians(180.0), vector.radians(-90.0), false);
    path.close();

    canvas.drawPath(path, Paint()..color = Colors.white);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
