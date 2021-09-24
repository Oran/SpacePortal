import 'package:flutter/material.dart';
import 'package:spaceportal/pages/settings_page/components/settings_button.dart';
import 'package:spaceportal/services/ad_helper.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
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
              onTap: () {},
              text: 'Licences',
            ),
            SettingsButton(
              onTap: () {},
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
