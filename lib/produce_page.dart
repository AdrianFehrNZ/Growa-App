import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:growa_app/produce_record.dart';

class ProducePage extends StatefulWidget {
  @override
  _ProducePageState createState() => _ProducePageState();
}

class _ProducePageState extends State<ProducePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Produce Encyclopedia'),
      ),
      body: Text('body'),
    );
  }
  Widget _buildBody(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('rides').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return LinearProgressIndicator();

        return _buildList(context, snapshot.data.documents);
      },
    );
  }

  Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: snapshot.map((data) => _buildListItem(context, data)).toList(),
    );
  }

  Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
    final produceRecord = ProduceRecord.fromSnapshot(data);

    return Padding(
      key: ValueKey(produceRecord.name),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5.0),
        ),
        child: ListTile(
            leading: new Image(
              image: new NetworkImage(produceRecord.image),
            ),
            title: Text(produceRecord.model + ", " + produceRecord.name),
            subtitle: Text(produceRecord.toString()),
            trailing: Text(produceRecord.price.toString()),
            isThreeLine: true,
            onTap: () {
//              Navigator.push(context,
//                  MaterialPageRoute(builder: (context) => DetailPage(record)));
            }),
      ),
    );
  }
}
