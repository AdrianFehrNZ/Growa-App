import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class OverviewPage extends StatelessWidget {
  static String tag = 'OverviewPage';

  @override
  Widget build(BuildContext context) {

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'My Garden',
        style: TextStyle(fontSize: 28.0, color: Colors.white),
      ),
    );

//    final gardenImages = CarouselSlider(
//      height: 400.0,
//      autoPlay: false,
//      enlargeCenterPage: true,
//      viewportFraction: 0.9,
//      aspectRatio: 2.0,
//    );

    final gardenImage = Padding(
      padding: EdgeInsets.all(10.0),
      child: Image.asset('assets/garden.jpg', fit: BoxFit.scaleDown),
    );

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.blue,
          Colors.lightBlueAccent,
        ]),
      ),
      child: CupertinoScrollbar(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              welcome,
              gardenImage,
              gardenImage,
              gardenImage
            ],
          ),
        ),
      ),
    );
  }
}
