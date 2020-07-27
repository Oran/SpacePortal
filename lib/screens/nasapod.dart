import 'dart:async';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:SpacePortal/constants.dart';
import 'package:SpacePortal/network/network.dart';
import 'package:url_launcher/url_launcher.dart';

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
      // backgroundColor: kPrimaryDarkPurple,
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
                    'SpaceX Launch Timetable',
                    style: kDetailsTS,
                  ),
                  onTap: () {
                    Navigator.pushNamed(context, kspaceX_ID);
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
      appBar: AppBar(
        title: Text('Picture of the day'),
        elevation: 0,
        backgroundColor: kAppBarColor,
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
                : Center(
                    child: Container(
                      height: 400.0,
                      width: 400.0,
                      child: FlareActor(
                        'assets/animations/space.flr',
                        animation: 'Untitled',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
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
    return list == null
        ? Center(
            child: Text(
              // '${list[6]}\nCheck back later\n\nError Code - ${list[5]}',
              'No internet conenction\nNo Response from API',
              textAlign: TextAlign.center,
              style: kTitleDateTS,
            ),
          )
        : list[5] == 404
            ? Center(
                child: Text(
                  '${list[6]}\nCheck back later\n\nError Code - ${list[5]}',
                  textAlign: TextAlign.center,
                  style: kTitleDateTS,
                ),
              )
            : ListView(
                physics: BouncingScrollPhysics(),
                children: <Widget>[
                  SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: list[0] == null
                        ? Center(
                            child: Text(
                              'Media not Provided',
                              style: kTitleDateTS.copyWith(color: Colors.red),
                            ),
                          )
                        : list[4] == 'video'
                            ? Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.0),
                                child: GestureDetector(
                                  onTap: () {
                                    launch(list[0]);
                                  },
                                  child: Text(
                                    '${list[0]}',
                                    textAlign: TextAlign.center,
                                    style:
                                        kDetailsTS.copyWith(color: Colors.red),
                                  ),
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(50.0),
                                child: Image.network(
                                  list[0],
                                ),
                              ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                    child: Text(
                      list[1] == null ? '' : list[1],
                      style: kTitleDateTS.copyWith(fontSize: 25.0),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                    child: Text(
                      list[2] == null ? '' : list[2],
                      style: kTitleDateTS.copyWith(fontSize: 18.0),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                      child: Text(
                        list[3] == null ? '' : list[3],
                        style: kDetailsTS.copyWith(
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),
                  ),
                ],
              );
  }
}
