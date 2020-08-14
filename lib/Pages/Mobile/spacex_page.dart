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
    );
  }
}
