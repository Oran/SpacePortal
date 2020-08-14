import 'package:SpacePortal/components/nasapod_page/pod_contents.dart';
import 'package:flutter/material.dart';
import 'package:SpacePortal/constants.dart';

class NasaPod extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: kPrimaryDarkPurple,
      drawer: Drawer(
        elevation: 20.0,
        child: Container(
          color: kDrawerColor,
          child: Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                  leading: Icon(
                    Icons.account_balance,
                    color: kIconColor,
                  ),
                  title: Text(
                    'SpaceX Launch Timetable',
                    style: kDetailsTS,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, kSpaceX_Page);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                  leading: Icon(
                    Icons.account_balance,
                    color: kIconColor,
                  ),
                  title: Text(
                    'Mars stuff',
                    style: kDetailsTS,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, kMars_Page);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: PODContents(),
    );
  }
}


