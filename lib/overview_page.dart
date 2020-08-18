import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'current_plant_card.dart';
import 'package:image_picker/image_picker.dart';

const Color _colorOne = Color(0x33000000);
const Color _colorTwo = Color(0x24000000);
const Color _colorThree = Color(0x1F000000);

class OverviewPage extends StatelessWidget {
  static String tag = 'OverviewPage';
  List<Widget> currentPlantList = [
    CurrentPlantCard(),
    CurrentPlantCard(),
    CurrentPlantCard(),
    CurrentPlantCard(),
    CurrentPlantCard(),
    CurrentPlantCard(),
    CurrentPlantCard(),
    CurrentPlantCard(),
    CurrentPlantCard(),
  ];

  @override
  Widget build(BuildContext context) {
    final overviewPageTitle = Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        'My Garden',
        style: TextStyle(fontSize: 28.0, color: Colors.white),
      ),
    );

    final nowGrowingTitle = Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        'Now Growing',
        style: TextStyle(fontSize: 20.0, color: Colors.white),
      ),
    );

    Future<void> _changeImageDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Icon(
              Icons.camera_alt,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'In future this function will allow you to change your garden image'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('Change'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    final gardenImage = Padding(
      padding: EdgeInsets.only(
        top: 0.0,
        right: 4.0,
        left: 4.0,
        bottom: 4.0,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 8.0,
        ),
        decoration: BoxDecoration(
          color: CupertinoColors.white,
          borderRadius: BorderRadius.circular(3.0),
          boxShadow: const <BoxShadow>[
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
        child: GestureDetector(
          onTap: _changeImageDialog,
          child: Image.asset('assets/garden.jpg', fit: BoxFit.scaleDown),
        ),
      ),
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
              overviewPageTitle,
              gardenImage,
              nowGrowingTitle,
              GridView.count(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                primary: false,
                childAspectRatio: 2 / 0.75,
                children: currentPlantList,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
