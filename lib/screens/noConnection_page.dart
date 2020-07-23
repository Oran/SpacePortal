import 'package:SpacePortal/constants.dart';
import 'package:flutter/material.dart';

class NoConnectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAccentdarkBlue,
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_off,
                size: 50.0,
                color: kPrimaryWhite,
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
