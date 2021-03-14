import 'dart:async';
import 'package:SpacePortal/Network/APODNetwork.dart';
import 'package:SpacePortal/Constants.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        APODData().getData(),
        Future.delayed(Duration(milliseconds: 1500)),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          SchedulerBinding.instance!.addPostFrameCallback((_) {
            Navigator.popAndPushNamed(context, kHome_Page);
          });
          return Container();
        } else {
          return Scaffold(
            body: Center(
              child: Container(
                color: Colors.white,
                height: 400.0,
                width: 400.0,
                child: FlareActor(
                  'assets/animations/space.flr',
                  animation: 'Untitled',
                  fit: BoxFit.fill,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
