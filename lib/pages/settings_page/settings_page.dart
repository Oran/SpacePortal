import 'package:flutter/material.dart';
import 'package:spaceportal/pages/settings_page/components/settings_button.dart';
import 'package:spaceportal/routes.dart';
import 'package:spaceportal/services/ad_helper.dart';
import 'package:spaceportal/utils/functions.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(
            color: theme.accentColor,
          ),
        ),
        centerTitle: false,
        iconTheme: IconThemeData(
          color: theme.accentColor,
        ),
      ),
      body: Container(
        height: (MediaQuery.of(context).size.height),
        width: (MediaQuery.of(context).size.width),
        child: Column(
          children: [
            SettingsButton(
              onTap: () {
                showLicensePage(
                  context: context,
                  applicationIcon: FlutterLogo(
                    size: 100,
                  ),
                  applicationName: 'Space Portal',
                  applicationVersion: 'v${AdUnitId.version}',
                );
              },
              text: 'Licences',
            ),
            SettingsButton(
              onTap: () {
                Navigator.push(context, routeTo(rVersionHistory));
              },
              text: 'Changelog',
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        child: Center(
          child: Text('Current Version v${AdUnitId.version}'),
        ),
      ),
    );
  }
}
