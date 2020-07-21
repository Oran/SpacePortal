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
        backgroundColor: kAccentdarkBlue,
        title: Text('SpaceX'),
      ),
      body: Container(
        height: (MediaQuery.of(context).size.height),
        width: (MediaQuery.of(context).size.width),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: kGradientSpaceBlue,
          ),
        ),
        child: SpaceXCard(spaceXList: spaceXList, spaceX: spaceX),
      ),
    );
  }
}
