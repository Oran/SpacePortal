import 'dart:ui';
import 'package:SpacePortal/constants.dart';
import 'package:SpacePortal/network/network.dart';
import 'package:cache_image/cache_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NasaPODViewer extends StatefulWidget {
  NasaPODViewer({this.date = ''});
  final String date;

  @override
  _NasaPODViewerState createState() => _NasaPODViewerState();
}

class _NasaPODViewerState extends State<NasaPODViewer> {
  OldNasaPodData oldData = OldNasaPodData();

  Future getData() async {
    oldData.setURL(widget.date);
    var ddata = await oldData.getOldNasaPodData();
    return ddata;
  }

  @override
  Widget build(BuildContext context) {
    var orientation = (MediaQuery.of(context).orientation);
    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryWhite,
              iconTheme: IconThemeData(
                color: snapshot.data[1] < 127 ? Colors.white : Colors.black,
              ),
              elevation: 10,
              flexibleSpace: Container(
                height: (MediaQuery.of(context).size.height),
                width: (MediaQuery.of(context).size.width),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: CacheImage(
                      snapshot.data[0].mediaType == 'video'
                          ? snapshot.data[0].videoThumb
                          : snapshot.data[0].image,
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                    child: Text(
                      '0',
                      style: TextStyle(color: Colors.transparent),
                    ),
                  ),
                ),
              ),
            ),
            body: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height:
                          orientation == Orientation.landscape ? 800.0 : null,
                      padding: EdgeInsets.all(10),
                      child: snapshot.data[0].mediaType == 'video'
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  launch(
                                    snapshot.data[0].videoURL,
                                    forceWebView: true,
                                    enableJavaScript: true,
                                  );
                                },
                                child: Column(
                                  children: [
                                    Text(
                                      'Tap to play video',
                                      style: kDetailsTS,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(30),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot.data[0].videoThumb,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                                color: Colors.black,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 10,
                                    blurRadius: 10,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30.0),
                                child: CachedNetworkImage(
                                  imageUrl: snapshot.data[0].image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                      child: Text(
                        snapshot.data[0].title,
                        style: kTitleDateTS.copyWith(
                          fontSize: 25.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                      child: Text(
                        snapshot.data[0].date,
                        style: kTitleDateTS.copyWith(
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: 15.0, vertical: 8.0),
                        child: Text(
                          snapshot.data[0].exp,
                          style: kDetailsTS.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.0),
                  ],
                ),
              ),
            ),
          );
        } else {
          return Scaffold(
            body: Center(
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
          );
        }
      },
    );
  }
}
