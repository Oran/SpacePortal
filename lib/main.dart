import 'package:SpacePortal/test.dart';
import 'package:flutter/material.dart';
import 'package:SpacePortal/screens/mars.dart';
import 'package:SpacePortal/screens/nasapod.dart';
import 'package:SpacePortal/screens/spacex.dart';
import 'package:flutter/services.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, // forces potrait mode for devices
      DeviceOrientation.portraitDown
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: nasapod_ID,
      routes: {
        nasapod_ID: (context) => NasaPod(),
        spaceX_ID: (context) => SpaceX(),
        mars_ID: (context) => Mars(),
        test_ID: (context) => Test(),
      },
    );
  }
}
