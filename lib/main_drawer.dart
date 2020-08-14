import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Row(
                children: <Widget>[
                  Image(
                    image: new NetworkImage(
                      "https://cdn.vox-cdn.com/thumbor/sR-BKibqOZGqn3ObBF_k9rCVf_o=/250x250/cdn.vox-cdn.com/uploads/chorus_asset/file/16256345/google_maps_parking_1.jpg",
                    ),
                  ),
                  Text('growa@gmail.com'),
                ],
              ),
            ),
            ListTile(
              title: Text('Trade'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            Divider(),
            ListTile(
              title: Text('Item 2'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            Divider(
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
