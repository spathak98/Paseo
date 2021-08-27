import 'package:flutter/material.dart';
import 'package:paseo/ui/splash_screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Paseo',
      theme: new ThemeData(
        primarySwatch: Colors.amber,

      ),
      home: SplashScreen(),
    );
  }
}
