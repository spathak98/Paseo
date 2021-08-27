import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import '../utils/locator.dart';

class LocationList extends StatefulWidget {
  @override
  _LocationListState createState() => _LocationListState();
}

class _LocationListState extends State<LocationList> {
  double locLatitude, locLongitude, distanceInMeters;

  Future<void> getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    locLatitude = location.latitude;
    locLongitude = location.longitude;
  }

  Future<void> getDistance(lat, long) async {
    distanceInMeters = await Geolocator()
        .distanceBetween(lat, long, locLatitude, locLongitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Choose"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            height: 30.0,
          ),
          Center(
            child: Hero(
              tag: 'Search',
              child: Image(
                image: AssetImage(
                  "assets/search.png",
                ),
                width: 100,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: Firestore.instance.collection('VIT Stops').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                      return Center(child: Text('Loading...'));

                    default:
                      return ListView(
                        children: snapshot.data.documents
                            .map((DocumentSnapshot document) {
                          return Card(
                            child: ListTile(
                              leading: Icon(Icons.pin_drop),
                              title: Text(document['name']),
                              onTap: () async {
//                                pr = new ProgressDialog(
//                                    context, type: ProgressDialogType.Normal,
//                                    isDismissible: false);
//                                pr.style(
//                                    message: 'Please Wait',
//                                    borderRadius: 10.0,
//                                    backgroundColor: Colors.white,
//                                    progressWidget: CircularProgressIndicator(),
//                                    elevation: 10.0,
//                                    insetAnimCurve: Curves.easeInOut,
//                                    progress: 25.0,
//                                    maxProgress: 100.0,
//                                    progressTextStyle: TextStyle(
//                                        color: Colors.black,
//                                        fontSize: 13.0,
//                                        fontWeight: FontWeight.w400),
//                                    messageTextStyle: TextStyle(
//                                        color: Colors.black,
//                                        fontSize: 19.0,
//                                        fontWeight: FontWeight.w600)
//                                );

//                                pr.show();
                                await getLocation();
                                await getDistance(document['latitude'],
                                    document['longitude']);
//                                await pr.hide();
                                if (distanceInMeters <= 100.0) {
                                  Firestore.instance
                                      .runTransaction((transaction) async {
                                    DocumentSnapshot freshSnap =
                                        await transaction
                                            .get(document.reference);
                                    await transaction
                                        .update(freshSnap.reference, {
                                      'count': freshSnap['count'] + 1,
                                    });
                                  });
                                  Navigator.pop(context, document.reference);
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text("An error occured!!"),
                                        content: Text("Not In Location radius"),
                                        actions: <Widget>[
                                          FlatButton(
                                            child: Text("Okay!!"),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    },
                                  );
                                }
                              },
                            ),
                          );
                        }).toList(),
                      );
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
