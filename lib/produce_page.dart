import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growa_app/planner_list_tile.dart';

const Color _colorOne = Color(0x33000000);
const Color _colorTwo = Color(0x24000000);
const Color _colorThree = Color(0x1F000000);

class ProducePage extends StatefulWidget {
  @override
  _ProducePageState createState() => _ProducePageState();
}

class _ProducePageState extends State<ProducePage> {
  int sharedValue = 0;
  PageController _pageController;
  var _scrollController = ScrollController();
  ScrollPhysics _physics = ClampingScrollPhysics();

  final producePlannerTitle = Padding(
    padding: EdgeInsets.only(
      left: 16.0,
      right: 16.0,
      top: 16.0,
    ),
    child: Text(
      'Produce Planner',
      style: TextStyle(fontSize: 28.0, color: Colors.white),
    ),
  );

  void _onItemTapped(int index) {
    setState(() {
      _pageController.jumpToPage(index);
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
    _pageController = PageController(initialPage: 0);

    _scrollController.addListener(() {
      if (_scrollController.position.pixels <= 56)
        setState(() => _physics = ClampingScrollPhysics());
      else
        setState(() => _physics = BouncingScrollPhysics());
    });
  }

  final Map<int, Widget> seasonLists = <int, Widget>{
    0: Text('Spring'),
    1: Text('Summer'),
    2: Text('Autumn'),
    3: Text('Winter'),
  };

  @override
  Widget build(BuildContext context) {
    ListView listView_0 = ListView.builder(
      itemCount: 20,
      itemBuilder: (BuildContext context, sharedValue) {
        return PlannerListTile(0);
      },
      physics: _physics,
      controller: _scrollController,
    );

    ListView listView_1 = ListView.builder(
      itemCount: 20,
      itemBuilder: (BuildContext context, sharedValue) {
        return PlannerListTile(1);
      },
      physics: _physics,
      controller: _scrollController,
    );

    ListView listView_2 = ListView.builder(
      itemCount: 20,
      itemBuilder: (BuildContext context, sharedValue) {
        return PlannerListTile(2);
      },
      physics: _physics,
      controller: _scrollController,
    );

    ListView listView_3 = ListView.builder(
      itemCount: 20,
      itemBuilder: (BuildContext context, sharedValue) {
        return PlannerListTile(3);
      },
      physics: _physics,
      controller: _scrollController,
    );

    return Scaffold(
      body: Container(
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
        child: Column(
          children: <Widget>[
            producePlannerTitle,
            Padding(
              padding: EdgeInsets.only(
                top: 0.0,
                left: 16.0,
                right: 16.0,
                bottom: 8.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: 8.0,
                horizontal: 16.0,
              ),
              child: Container(
                width: MediaQuery.of(context).size.width - 32.0,
                decoration: BoxDecoration(
                  color: CupertinoColors.white,
                  borderRadius: BorderRadius.circular(3.0),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      offset: Offset(0.0, 3.0),
                      blurRadius: 5.0,
                      spreadRadius: -1.0,
                      color: _colorOne,
                    ),
                    BoxShadow(
                      offset: Offset(0.0, 6.0),
                      blurRadius: 10.0,
                      spreadRadius: 0.0,
                      color: _colorTwo,
                    ),
                    BoxShadow(
                      offset: Offset(0.0, 1.0),
                      blurRadius: 18.0,
                      spreadRadius: 0.0,
                      color: _colorThree,
                    ),
                  ],
                ),
                child: CupertinoSegmentedControl<int>(
                  padding: EdgeInsets.symmetric(
                    horizontal: 0.0,
                  ),
                  borderColor: Colors.transparent,
                  selectedColor: Color.fromRGBO(61, 8, 89, 100),
                  unselectedColor: Colors.white,
                  pressedColor: Color.fromRGBO(61, 8, 89, 100),
                  children: seasonLists,
                  onValueChanged: (int val) {
                    setState(
                      () {
                        sharedValue = val;
                        _onItemTapped(sharedValue);
                      },
                    );
                  },
                  groupValue: sharedValue,
                ),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() => sharedValue = index);
                },
                children: <Widget>[
                  listView_0,
                  listView_1,
                  listView_2,
                  listView_3,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//  Widget _buildBody(BuildContext context) {
//    return StreamBuilder<QuerySnapshot>(
//      stream: Firestore.instance.collection('rides').snapshots(),
//      builder: (context, snapshot) {
//        if (!snapshot.hasData) return LinearProgressIndicator();
//
//        return _buildList(context, snapshot.data.documents);
//      },
//    );
//  }
//
//  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
//    return ListView(
//      padding: const EdgeInsets.only(top: 20.0),
//      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
//    );
//  }
//
//  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
//    return Padding(
//      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//      child: Container(
//        decoration: BoxDecoration(
//          border: Border.all(color: Colors.black),
//          borderRadius: BorderRadius.circular(5.0),
//        ),
//        child: ListTile(
//            leading: Image(
//              image: AssetImage('assets/logo.jpg'),
//            ),
//            isThreeLine: true,
//            onTap: () {
////              Navigator.push(context,
////                  MaterialPageRoute(builder: (context) => DetailPage(record)));
//            }),
//      ),
//    );
//  }
}
