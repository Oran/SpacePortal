import 'package:flutter/material.dart';
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
    result = await spaceX.getSpaceXData();

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
        child: Column(
          children: <Widget>[
            spaceXList == null
                ? Text('')
                : Text(spaceXList[0]),
            spaceXList == null
                ? Text('')
                : Text(spaceXList[1].toString()),
            spaceXList == null
                ? Text('')
                : Text(spaceXList[2]),
            RaisedButton(
              onPressed: () {
                spaceX.getSpaceXData();
              },
            ),
          ],
        ),
      ),
    );
  }
}
