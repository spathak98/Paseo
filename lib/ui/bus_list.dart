import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BusList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buses"),
        backgroundColor: Color(0xFF8a66ff),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('VIT Stops').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.lightBlueAccent,
                    ),
                  );
                }
                return ListView(
                    children: snapshot.data.documents
                        .map((DocumentSnapshot document) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15.0, vertical: 5),
                    child: Card(
                      elevation: 15.0,
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            Text(
                              document['name'],
                              style: TextStyle(
                                  fontFamily: 'WorkSansMedium', fontSize: 16.0),
                            ),
                            SizedBox(
                              height: 50.0,
                            ),
                            Text(
                              document['count'].toString(),
                              style: document['count'] < 20
                                  ? TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'WorkSansMedium',
                                      fontSize: 20.0)
                                  : TextStyle(
                                      color: Colors.red,
                                      fontFamily: 'WorkSansMedium',
                                      fontSize: 20.0),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }).toList());
              },
            ),
          )
        ],
      ),
    );
  }
}

//Card(
//child: Padding(
//padding: EdgeInsets.all(10.0),
//child: Row(
//mainAxisAlignment: MainAxisAlignment.spaceBetween,
//children: <Widget>[
//Text("Boys Hostel"),
//SizedBox(
//height: 50.0,
//),
//Text(
//"50",
//style: TextStyle(color: Colors.red),
//),
//],
//),
//),
//),
