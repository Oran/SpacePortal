import 'package:spaceportal/constants.dart';
import 'package:flutter/material.dart';
import 'package:spaceportal/utils/functions.dart';

class NoConnectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 400.0,
                width: 400.0,
                child: flareLoadingAnimation(),
              ),
              Icon(
                Icons.cloud_off,
                size: 50.0,
                color: Colors.black,
              ),
              Text(
                'No Connection',
                textAlign: TextAlign.center,
                style: kTitleDateTS.copyWith(
                  fontSize: 30.0,
                ),
              ),
              Divider(
                color: Colors.black,
                thickness: 1.5,
                height: 10.0,
                endIndent: 50.0,
                indent: 50.0,
              ),
              Text(
                'Please connect to the internet and restart to use this app',
                textAlign: TextAlign.center,
                style: kTitleDateTS.copyWith(
                  fontSize: 21.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
