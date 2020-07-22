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
    getImageData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAccentdarkBlue,
      drawer: Drawer(
        elevation: 20.0,
        child: Container(
          color: kAccentdarkBlue,
          child: Padding(
            padding: EdgeInsets.only(top: 40.0),
            child: Column(
              children: [
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                  leading: Icon(
                    Icons.account_balance,
                    color: kPrimaryWhite,
                  ),
                  title: Text(
                    'SpaceX Launch Timetable',
                    style: kDetailsTS,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, spaceX_ID);
                  },
                ),
                ListTile(
                  contentPadding: EdgeInsets.symmetric(horizontal: 25.0),
                  leading: Icon(
                    Icons.account_balance,
                    color: kPrimaryWhite,
                  ),
                  title: Text(
                    'Mars stuff',
                    style: kDetailsTS,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, mars_ID);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Picture of the day'),
        elevation: 0,
        backgroundColor: kAccentdarkBlue,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
                child: Icon(Icons.cached),
                onTap: () {
                  getImageData();
                }),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Future.delayed(Duration(seconds: 2)),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.done
                ? PODContents(list: list, networkData: networkData)
                : Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class PODContents extends StatelessWidget {
  const PODContents({
    @required this.list,
    @required this.networkData,
  });

  final List list;
  final NasaPODData networkData;

  @override
  Widget build(BuildContext context) {
    return list[5] == 404
        ? Center(
            child: Text(
              'Data is not provided yet check back later\n\nError Code - ${list[5]}',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
              ),
            ),
          )
        : GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: kAccentdarkBlue,
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(5),
                  // height: (MediaQuery.of(context).size.height) * 0.50,
                  // width: (MediaQuery.of(context).size.width) * 0.99,
                  child: list[0] == null
                      ? Center(
                          child: Text(
                            'Media not Provided',
                            style: kTitleDateTS.copyWith(color: Colors.red),
                          ),
                        )
                      : list[4] == 'video'
                          ? Text('data')
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(50.0),
                              child: Image.network(
                                list[0],
                              ),
                            ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    list[1] == null ? '' : list[1],
                    style: kTitleDateTS.copyWith(fontSize: 25.0),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    list[2] == null ? '' : list[2],
                    style: kTitleDateTS.copyWith(fontSize: 18.0),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      list[3] == null ? '' : list[3],
                      style: kDetailsTS,
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
