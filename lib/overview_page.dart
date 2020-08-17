import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

    final gardenImage = Padding(
      padding: EdgeInsets.all(10.0),
      child: Image.asset('assets/garden.jpg', fit: BoxFit.scaleDown),
    );

    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [
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
            ],
          ),
        ),
      ),
    );
  }
}
