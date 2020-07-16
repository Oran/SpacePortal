import 'package:flutter/material.dart';
import 'package:flutterPlayground/screens/nasapod.dart';
import 'package:flutterPlayground/screens/spacex.dart';
import 'constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: nasapodID,
      routes: {
        nasapodID: (context) => NasaPod(),
        spaceXID: (context) => SpaceX(),
      },
    );
  }
}
