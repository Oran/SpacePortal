import 'package:spaceportal/constants.dart';
import 'package:flutter/material.dart';
import 'package:spaceportal/utils/functions.dart';

class NoConnectionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(),
      extendBodyBehindAppBar: true,
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
                Icons.cloud_off_rounded,
                size: 50.0,
                color: theme.accentColor,
              ),
              Text(
                'No Connection',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 30,
                ),
              ),
              Divider(
                color: theme.accentColor,
                thickness: 1.5,
                height: 10.0,
                endIndent: 50.0,
                indent: 50.0,
              ),
              Text(
                'Please connect to the internet and restart to use this app',
                textAlign: TextAlign.center,
                style: theme.textTheme.bodyText1?.copyWith(
                  fontSize: 21,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
