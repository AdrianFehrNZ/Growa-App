import 'package:flutter/material.dart';

class PlannerListTile extends StatefulWidget {
  final int seasonNo;

  const PlannerListTile(this.seasonNo);

  @override
  _PlannerListTileState createState() =>
      _PlannerListTileState(seasonNo: this.seasonNo);
}

class _PlannerListTileState extends State<PlannerListTile> {
  _PlannerListTileState({this.seasonNo});

  int seasonNo;
  String assetImageName, season;
  bool isTicked = false;

  @override
  Widget build(BuildContext context) {
    switch (this.seasonNo) {
      case 0:
        {
          this.assetImageName = 'assets/beetroot.jpg';
          this.season = 'Spring';
        }
        break;
      case 1:
        {
          this.assetImageName = 'assets/tomato.jpg';
          this.season = 'Summer';
        }
        break;
      case 2:
        {
          this.assetImageName = 'assets/broccoli.jpg';
          this.season = 'Autumn';
        }
        break;
      case 3:
        {
          this.assetImageName = 'assets/carrot.jpg';
          this.season = 'Winter';
        }
        break;
      default:
        {
          this.assetImageName = 'assets/logo.jpg';
          this.season = '';
        }
        break;
    }
    return Card(
      margin: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 8.0,
      ),
      child: ListTile(
        leading: Image(
          image: AssetImage(this.assetImageName),
        ),
        title: Text(this.season + ' Vegetable'),
        subtitle: Text('SAMPLE SAMPLE SAMPLE SAMPLE'),
        trailing: InkWell(
          onTap: () {
            isTicked = !isTicked;
            setState(() {});
          },
          child: isTicked
              ? Icon(
                  Icons.check_circle,
                  color: Colors.lightGreen,
                )
              : Icon(
                  Icons.check_circle_outline,
                  color: Colors.grey,
                ),
        ),
      ),
    );
  }
}
