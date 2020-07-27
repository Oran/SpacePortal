import 'package:SpacePortal/constants.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flare_flutter/flare_cache.dart';
import 'package:flutter/material.dart';

class NoConnectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryBlack,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 400.0,
                width: 400.0,
                child: FlareActor(
                  'assets/animations/space.flr',
                  animation: 'Untitled',
                  fit: BoxFit.fill,
                ),
              ),
              Icon(
                Icons.cloud_off,
                size: 50.0,
                color: kIconColor,
              ),
              Text(
                'No Connection',
                textAlign: TextAlign.center,
                style: kTitleDateTS.copyWith(
                  fontSize: 30.0,
                ),
              ),
              Divider(
                color: Colors.white,
                thickness: 1.5,
                height: 10.0,
                endIndent: 50.0,
                indent: 50.0,
              ),
              Text(
                'Please connect to internet and restart to use this app',
                textAlign: TextAlign.center,
                style: kTitleDateTS.copyWith(
                  fontSize: 23.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
