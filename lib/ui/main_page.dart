import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:paseo/ui/bus_info.dart';
import 'package:paseo/ui/location_list.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Completer<GoogleMapController> _controller = Completer();
  DocumentReference value;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(23.077581, 76.851269),
    zoom: 18.0,
  );

  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("Locator"),
          backgroundColor: Colors.amber,
          actions: <Widget>[
            GestureDetector(
              child: Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
              onTap: () async {
                if (value != null) {
                  showInSnackBar("Wait Checking Out!");
                  await Firestore.instance.runTransaction((transaction) async {
                    DocumentSnapshot freshSnap = await transaction.get(value);
                    await transaction.update(freshSnap.reference, {
                      'count': freshSnap['count'] - 1,
                    });
                  });
                  value = null;
                  showInSnackBar("Checked Out");
                } else {
                  showInSnackBar("Kindly Choose A Location");
                }
              },
            )
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              ListTile(
                title: Text("Bus Info"),
                leading: Icon(Icons.info_outline),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => BusInfo(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: Stack(
          children: <Widget>[
            GoogleMap(
              mapType: MapType.satellite,
              initialCameraPosition: _kGooglePlex,
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
              myLocationEnabled: true,
              compassEnabled: true,
            ),
            Positioned(
              top: 100.0,
              left: 70.0,
              child: MaterialButton(
                splashColor: Colors.white,
                height: 40,
                elevation: 10.0,
                color: Colors.redAccent.withOpacity(0.7),
                onPressed: () async {
                  value = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LocationList(),
                    ),
                  );
                },
                minWidth: 250,
                child: Row(
                  children: <Widget>[
                    Text(
                      'Choose A Location',
                      style: TextStyle(
                          fontFamily: 'WorkSansMedium', fontSize: 20.0),
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Hero(
                      tag: 'Search',
                      child: Image(
                        image: AssetImage(
                          "assets/search.png",
                        ),
                        width: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showInSnackBar(String value) {
    FocusScope.of(context).requestFocus(new FocusNode());
    _scaffoldKey.currentState?.removeCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text(
        value,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontFamily: "WorkSansSemiBold"),
      ),
      backgroundColor: Colors.blue,
      duration: Duration(seconds: 3),
    ));
  }
}
