import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  static String tag = 'StatsPage';

  @override
  Widget build(BuildContext context) {
//    return Hero(
//      tag: 'stats',
//      return Dismissible(
//        direction: DismissDirection.vertical,
//        key: UniqueKey(),
//        return Material(
//          color: Colors.transparent,
    return GestureDetector(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          actions: <Widget>[
            IconButton(
              icon: CloseButton(),
            ),
          ],
        ),
        body: Image.asset('assets/chart.png'),
      ),
    );
  }
}
