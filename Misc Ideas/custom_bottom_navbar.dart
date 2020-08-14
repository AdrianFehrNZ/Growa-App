import 'package:flutter/material.dart';

Widget customBottomNavigationBar(
    BuildContext context, TabController tabController) {
  double _height = MediaQuery.of(context).size.height * 0.035;

  if (MediaQuery.of(context).orientation == Orientation.landscape){
    _height = MediaQuery.of(context).size.height * 0.07;
  }

  return AnimatedContainer(
    duration: Duration(milliseconds: 500),
    height: _height,
    width: MediaQuery.of(context).size.width,
    child: TabBar(
      controller: tabController,
      tabs: [
        Tab(
          text: 'Overview',
        ),
        Tab(
          text: 'Two',
        ),
        Tab(
          text: 'Three',
        ),
      ],
      labelColor: Colors.black,
      unselectedLabelColor: Colors.blueGrey,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorColor: Colors.blue,
    ),
  );
}
