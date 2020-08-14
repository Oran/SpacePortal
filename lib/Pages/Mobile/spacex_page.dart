import 'package:SpacePortal/constants.dart';
import 'package:flutter/material.dart';
import 'package:SpacePortal/components/spacex_page/spaceX_card.dart';

class SpaceX extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: kAppBarColor,
        title: Text('SpaceX'),
      ),
      body: Container(
        height: (MediaQuery.of(context).size.height),
        width: (MediaQuery.of(context).size.width),
        // color: kPrimaryDarkPurple,
        child: SpaceXCard(),
      ),
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
                    'NASA Picture of the day',
                    style: kDetailsTS,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, kNASAPod_Page);
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
    );
  }
}
