import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../lib/overview_page.dart';

class PageViewController extends StatefulWidget {
  final ValueListenable notifier;
  PageViewController(this.notifier, this.callback);
  Function(int) callback;

  @override
  _PageViewControllerState createState() => _PageViewControllerState();
}

class _PageViewControllerState extends State<PageViewController> {
  PageController _controller;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    // TODO: implement setState
  }

  @override
  void initState() {
    super.initState();
    _controller = PageController(
      initialPage: 1,
      keepPage: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        onPageChanged: (index) {
          widget.callback(index);
        },
        children: <Widget>[
          OverviewPage(),
          OverviewPage(),
          OverviewPage(),
        ],
      ),
    );
  }
}
