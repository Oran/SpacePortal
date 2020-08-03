import 'dart:async';
import 'package:SpacePortal/components/web/pod_row.dart';
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
  var list;

  Future getImageData() async {
    return await networkData.getData();
  }

  @override
  void initState() {
    list = getImageData();
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
          future: list,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return PODContents(list: snapshot.data, networkData: networkData);
            } else {
              return Center(
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
              );
            }
          }),
    );
  }
}

class PODContents extends StatelessWidget {
  PODContents({
    @required this.list,
    @required this.networkData,
  });

  final list;
  final NasaPODData networkData;
  final box = Hive.box('cache');

  @override
  Widget build(BuildContext context) {
    var orientation = (MediaQuery.of(context).orientation);
    return list == null
        ? Center(
            child: Text(
              'No Response from API',
              textAlign: TextAlign.center,
              style: kTitleDateTS,
            ),
          )
        : box.get('image') == null
            ? Center(
                child: Text(
                  'Data not provided yet, \nmaybe check back later',
                  textAlign: TextAlign.center,
                  style: kTitleDateTS.copyWith(
                    color: Colors.red[300],
                    fontSize: 20.0,
                  ),
                ),
              )
            : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: orientation == Orientation.landscape
                    //TODO: Fix sizing error for larger images. (don't hard code)
                    ? PODRow(orientation: orientation, list: list, box: box)
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10),
                          Container(
                            height: orientation == Orientation.landscape
                                ? 800.0
                                : null,
                            padding: EdgeInsets.all(10),
                            // color: Colors.green,
                            child: list[0] == 'video'
                                ? Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: GestureDetector(
                                      onTap: () {
                                        launch(Hive.box('cacge').get('image'));
                                      },
                                      child: Text(
                                        '${Hive.box('cache').get('image')}',
                                        textAlign: TextAlign.center,
                                        style: kDetailsTS.copyWith(
                                            color: Colors.red),
                                      ),
                                    ),
                                  )
                                : ClipRRect(
                                    borderRadius: BorderRadius.circular(50.0),
                                    child: kIsWeb
                                        ? Image(
                                            image: NetworkImage(
                                              box.get('image'),
                                            ),
                                            fit: BoxFit.fill,
                                          )
                                        : CachedNetworkImage(
                                            imageUrl: box.get('image'),
                                            fit: BoxFit.fill,
                                          ),
                                  ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 8.0),
                            child: Text(
                              box.get('title'),
                              style: kTitleDateTS.copyWith(fontSize: 25.0),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15.0, vertical: 8.0),
                            child: Text(
                              box.get('date'),
                              style: kTitleDateTS.copyWith(fontSize: 18.0),
                            ),
                          ),
                          Container(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.0, vertical: 8.0),
                              child: Text(
                                box.get('exp'),
                                style: kDetailsTS.copyWith(
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
              );
  }
}
