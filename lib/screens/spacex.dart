import 'package:flutter/material.dart';
import 'package:SpacePortal/components/space_x_card.dart';
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
        title: Text('SpaceX'),
      ),
      body: SpaceXCard(spaceXList: spaceXList, spaceX: spaceX),
    );
  }
}
