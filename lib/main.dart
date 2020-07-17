import 'package:flutter/material.dart';
import 'package:SpacePortal/screens/mars.dart';
import 'package:SpacePortal/screens/nasapod.dart';
import 'package:SpacePortal/screens/spacex.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: marsID,
      routes: {
        nasapodID: (context) => NasaPod(),
        spaceXID: (context) => SpaceX(),
        marsID: (context) => Mars(),
      },
    );
  }
}
