import 'dart:async';

import 'package:flutter/material.dart';
import 'package:SpacePortal/constants.dart';
import 'package:SpacePortal/network/network.dart';

class NasaPod extends StatefulWidget {
  @override
  _NasaPodState createState() => _NasaPodState();
}

class _NasaPodState extends State<NasaPod> {
  NasaPODData networkData = NasaPODData();
  List result;
  List list;

  Future getImageData() async {
    result = await networkData.getData();
    setState(() {
      list = result;
    });
  }

  @override
  void initState() {
    Timer(Duration(seconds: 5), () => getImageData());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: Drawer(
          elevation: 20.0,
          child: Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                  leading: Icon(Icons.account_balance),
                  title: Text('SpaceX Launch Timetable'),
                  onTap: () {
                    Navigator.pushNamed(context, spaceX_ID);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                  leading: Icon(Icons.account_balance),
                  title: Text('Mars stuff'),
                  onTap: () {
                    Navigator.pushNamed(context, mars_ID);
                  },
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: Text('Picture of the day'),
        ),
        body: list[5] == 404
            ? Center(
                child: Text(
                  'Data is not provided yet, check back later \n Error Code - ${list[4]}',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              )
            : Column(
                children: <Widget>[
                  Container(
                    height: (MediaQuery.of(context).size.height) * 0.50,
                    width: (MediaQuery.of(context).size.width) * 0.99,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 2,
                      ),
                    ),
                    child: list[0] == null
                        ? Text('Media not Provided')
                        : list[4] == 'video'
                            ? Text('Output is a video')
                            : Image.network(
                                list[0],
                              ),
                  ),
                  Text(
                    list[1] == null ? '' : list[1],
                    style: TextStyle(fontSize: 25),
                  ),
                  Text(
                    list[2] == null ? '' : list[2],
                    style: TextStyle(fontSize: 18),
                  ),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        Container(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              list[3] == null ? '' : list[3],
                              style: TextStyle(fontSize: 15),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  RaisedButton(
                    child: Text('Tap Me'),
                    onPressed: () {
                      networkData.getData();
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
