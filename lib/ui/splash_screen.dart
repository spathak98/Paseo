import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flare_flutter/flare_actor.dart';
import 'package:paseo/ui/driver_login.dart';
import 'package:paseo/ui/login_page.dart';
import 'package:paseo/style/theme.dart' as Theme;

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //* time duration . to indicate how much time the screen will be present
//    Timer(
//      Duration(seconds: 3),
//
//      () => Navigator.of(context).pushReplacement(
//        MaterialPageRoute(
//          builder: (BuildContext context) => LoginPage(),
//        ),
//      ),
//    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    Colors.yellow,
                    Colors.orange,
                  ],
                  begin: const FractionalOffset(0.0, 0.0),
                  end: const FractionalOffset(1.0, 1.0),
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
          ),
          Container(
            // *Logo animation in splashscreen
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 2,
                  child: FlareActor(
                    "assets/Paseo Anim.flr",
                    fit: BoxFit.contain,
                    animation: "bounce",
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Theme.Colors.loginGradientStart,
                              offset: Offset(1.0, 6.0),
                              blurRadius: 20.0,
                            ),
                            BoxShadow(
                              color: Theme.Colors.loginGradientEnd,
                              offset: Offset(1.0, 6.0),
                              blurRadius: 20.0,
                            ),
                          ],
                          gradient: new LinearGradient(
                              colors: [
                                Theme.Colors.loginGradientEnd,
                                Theme.Colors.loginGradientStart
                              ],
                              begin: const FractionalOffset(0.2, 0.2),
                              end: const FractionalOffset(1.0, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        child: MaterialButton(
                          highlightColor: Colors.transparent,
                          splashColor: Theme.Colors.loginGradientEnd,
                          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 42.0),
                            child: Text(
                              "COMMUTER",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontFamily: "WorkSansBold"),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => LoginPage(),
                              ),
                            );

                          },
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Theme.Colors.loginGradientStart,
                              offset: Offset(1.0, 6.0),
                              blurRadius: 20.0,
                            ),
                            BoxShadow(
                              color: Theme.Colors.loginGradientEnd,
                              offset: Offset(1.0, 6.0),
                              blurRadius: 20.0,
                            ),
                          ],
                          gradient: new LinearGradient(
                              colors: [
                                Theme.Colors.loginGradientEnd,
                                Theme.Colors.loginGradientStart
                              ],
                              begin: const FractionalOffset(0.2, 0.2),
                              end: const FractionalOffset(1.0, 1.0),
                              stops: [0.0, 1.0],
                              tileMode: TileMode.clamp),
                        ),
                        child: MaterialButton(
                          highlightColor: Colors.transparent,
                          splashColor: Theme.Colors.loginGradientEnd,
                          //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 42.0),
                            child: Text(
                              "DRIVER",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25.0,
                                  fontFamily: "WorkSansBold"),
                            ),
                          ),
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (BuildContext context) => DriverLogin(),
                              ),
                            );

                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
