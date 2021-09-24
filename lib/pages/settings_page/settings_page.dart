import 'package:flutter/material.dart';

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
            //TODO: Add buttons here.
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 80,
        child: Center(
          //TODO: Display current version number here.
          child: null,
        ),
      ),
    );
  }
}
