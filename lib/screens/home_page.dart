import 'package:SpacePortal/constants.dart';
import 'package:SpacePortal/screens/mars.dart';
import 'package:SpacePortal/screens/nasapod.dart';
import 'package:SpacePortal/screens/spacex.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: BouncingScrollPhysics(),
        children: [
          NasaPod(),
          SpaceX(),
          Mars(),
        ],
      ),
    );
  }
}
