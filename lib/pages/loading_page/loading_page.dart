import 'dart:async';
import 'package:spaceportal/network/apod_network.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:spaceportal/network/articles_network.dart';
import 'package:spaceportal/network/launch_network.dart';
import 'package:spaceportal/pages/home_page/home_page.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.wait([
        APODData().setDataToCache(),
        ArticleAPI().setDataToCache(),
        LaunchNetwork().setDataToCache(),
        Future.delayed(Duration(milliseconds: 750)),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return HomePage();
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
