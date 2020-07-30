import 'package:SpacePortal/constants.dart';
import 'package:flutter/material.dart';
import 'package:SpacePortal/components/spaceX_card.dart';
import 'package:SpacePortal/network/network.dart';

class SpaceX extends StatefulWidget {
  @override
  _SpaceXState createState() => _SpaceXState();
}

class _SpaceXState extends State<SpaceX> {
  SpaceXData spaceX = SpaceXData();
  List result;
  List spaceXList;

  Future getDataSpaceX() async {
    result = await spaceX.getData();

    setState(() {
      spaceXList = result;
    });
  }

  @override
  void initState() {
    getDataSpaceX();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: kAppBarColor,
        flexibleSpace: Container(decoration: kAppbarBoxDecoration),
        title: Text('SpaceX'),
      ),
      body: Container(
        height: (MediaQuery.of(context).size.height),
        width: (MediaQuery.of(context).size.width),
        // color: kPrimaryDarkPurple,
        child: SpaceXCard(spaceXList: spaceXList, spaceX: spaceX),
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
                    Navigator.pushNamed(context, knasapod_ID);
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
                    Navigator.pushNamed(context, kmars_ID);
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
