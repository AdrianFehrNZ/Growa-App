import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:percent_indicator/percent_indicator.dart';

class CurrentPlantCard extends StatefulWidget {
  @override
  _CurrentPlantCardState createState() => _CurrentPlantCardState();
}

class _CurrentPlantCardState extends State<CurrentPlantCard> {
  var rand = new Random();

  Color _calculateColor(double percentage) {
    if (percentage < 0.2) {
      return Colors.red;
    } else if (percentage < 0.6) {
      return Colors.yellow;
    } else if (percentage < 1.0) {
      return Colors.green;
    } else {
      return Colors.green;
    }
  }

  Widget _readinessCenterWidgetText(double percentage) {
    if (percentage > 0.95) {
      return Text('Ready');
    } else {
      return Text((percentage * 100).round().toString() + '%');
    }
  }

  @override
  Widget build(BuildContext context) {
    double percentageComplete = rand.nextDouble();
    var width = MediaQuery.of(context).size.width;
    Color color = _calculateColor(percentageComplete);

    Future<void> _currentPlantTappedDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: CircularPercentIndicator(
              radius: width / 8,
              lineWidth: 5.0,
              percent: percentageComplete,
              center: Expanded(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage('assets/plant.png'),
                  ),
                ),
              ),
              progressColor: color,
              animation: true,
              animationDuration: 500,
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                    'Sample Vegetable',
                    style: TextStyle(fontSize: 28.0, color: Colors.lightBlue),
                  ),
                  SizedBox(height: 8.0),
                  Text('Details'),
                  SizedBox(height: 8.0),
                  Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit, '
                      'sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                      'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris '
                      'nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in '
                      'reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. '
                      'Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt '
                      'mollit anim id est laborum.'),
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return GestureDetector(
      onTap: _currentPlantTappedDialog,
      child: Card(
        elevation: 2,
        child: ClipPath(
          child: Container(
            height: 100,
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: Colors.green, width: 5),
              ),
            ),
            child: Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SizedBox.expand(),
                ),
                Expanded(
                  flex: 3,
                  child: Image(
                    image: AssetImage('assets/plant.png'),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: SizedBox.expand(),
                ),
                Expanded(
                  flex: 4,
                  child: Text('SAMPLE VEGETABLE'),
                ),
                Expanded(
                  flex: 4,
                  child: CircularPercentIndicator(
                    radius: width / 8,
                    lineWidth: 5.0,
                    percent: percentageComplete,
                    center: _readinessCenterWidgetText(percentageComplete),
                    progressColor: color,
                    animation: true,
                    animationDuration: 900,
                  ),
                ),
              ],
            ),
          ),
          clipper: ShapeBorderClipper(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(3),
            ),
          ),
        ),
      ),
    );
  }
}
