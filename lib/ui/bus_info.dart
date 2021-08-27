import 'package:flutter/material.dart';

class BusInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Buses"),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Card(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Main Gate"),
                  SizedBox(
                    height: 50.0,
                  ),
                  Text("No Bus Running"),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Boys Hostel"),
                  SizedBox(
                    height: 50.0,
                  ),
                  Text("No Bus Running"),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Girls Hostel"),
                  SizedBox(
                    height: 50.0,
                  ),
                  Text("No Bus Running"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
