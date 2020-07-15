import 'package:flutter/material.dart';
import 'package:flutterPlayground/components/space_x_card.dart';
import 'package:flutterPlayground/network/network.dart';

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
      body: Container(
        child: SpaceXCard(spaceXList: spaceXList, spaceX: spaceX),
      ),
    );
  }
}
