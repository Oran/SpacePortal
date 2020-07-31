import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:SpacePortal/constants.dart';
import 'package:SpacePortal/network/network.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:hive/hive.dart';

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
    var orientation = (MediaQuery.of(context).orientation);
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
                    Navigator.pushNamed(context, kSpaceX_Page);
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
                    Navigator.pushNamed(context, kMars_Page);
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
        //backgroundColor: kAppBarColor,
        flexibleSpace: Container(decoration: kAppbarBoxDecoration),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
                child: Icon(Icons.cached),
                onTap: () {
                  NasaPODData().getData();
                }),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Future.delayed(Duration(milliseconds: 1500)),
        builder: (context, snapshot) =>
            snapshot.connectionState == ConnectionState.done
                ? PODContents(list: list, networkData: networkData)
                : Center(
                    child: Container(
                      height: kIsWeb && (orientation == Orientation.landscape)
                          ? 700.0
                          : 400.0,
                      width: kIsWeb && (orientation == Orientation.landscape)
                          ? 700.0
                          : 400.0,
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
  PODContents({
    @required this.list,
    @required this.networkData,
  });

  final List list;
  final NasaPODData networkData;
  final box = Hive.box('cache');

  @override
  Widget build(BuildContext context) {
    return list == null
        ? Center(
            child: Text(
              'No internet conenction\nNo Response from API',
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
                child: list[0] == 'video'
                    ? Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            launch(Hive.box('cacge').get('image'));
                          },
                          child: Text(
                            '${Hive.box('cache').get('image')}',
                            textAlign: TextAlign.center,
                            style: kDetailsTS.copyWith(color: Colors.red),
                          ),
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(50.0),
                        //TODO: Fix this for the web version.
                        child: kIsWeb
                            ? Image.network(
                                box.get('image'),
                                fit: BoxFit.fill,
                              )
                            : CachedNetworkImage(
                                imageUrl: box.get('image'),
                                fit: BoxFit.fill,
                              ),
                      ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                child: Text(
                  box.get('title'),
                  style: kTitleDateTS.copyWith(fontSize: 25.0),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                child: Text(
                  box.get('date'),
                  style: kTitleDateTS.copyWith(fontSize: 18.0),
                ),
              ),
              Container(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                  child: Text(
                    box.get('exp'),
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
