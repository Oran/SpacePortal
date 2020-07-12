import 'package:flutter/material.dart';
import 'package:flutterPlayground/network/network.dart';

class SpaceX extends StatefulWidget {
  @override
  _SpaceXState createState() => _SpaceXState();
}

class _SpaceXState extends State<SpaceX> {
  SpaceXData spaceX = SpaceXData();
  String result;
  String text;

  Future getDataSpaceX() async {
    result = await spaceX.getSpaceXData();
    setState(() {
      text = result;
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
            Text(text == null ? 'text is null' : text),
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
