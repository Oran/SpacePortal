import 'package:SpacePortal/screens/mars.dart';
import 'package:SpacePortal/screens/nasapod.dart';
import 'package:SpacePortal/screens/spacex.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var ori = MediaQuery.of(context).orientation;
    return Scaffold(
      body: ori == Orientation.landscape
          ? NasaPod()
          : PageView(
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
