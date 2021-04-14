import 'dart:ui';
import 'package:spaceportal/Network/APODNetwork.dart';
import 'package:spaceportal/Constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class APODViewer extends StatefulWidget {
  APODViewer({this.date = ''});
  final String? date;

  @override
  _APODViewerState createState() => _APODViewerState();
}

class _APODViewerState extends State<APODViewer> {
  OldAPODData oldData = OldAPODData();

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
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryWhite,
              iconTheme: IconThemeData(
                color: snapshot.data[1] < 127 ? Colors.white : Colors.black,
              ),
              elevation: 10,
              flexibleSpace: ImageFiltered(
                imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                child: Container(
                  height: (MediaQuery.of(context).size.height),
                  width: (MediaQuery.of(context).size.width),
                  child: CachedNetworkImage(
                    imageUrl: snapshot.data[0].mediaType == 'video'
                        ? snapshot.data[0].videoThumb
                        : snapshot.data[0].mediaType == 'other'
                            ? kPlaceholderImageBlack
                            : snapshot.data[0].image,
                    fit: BoxFit.cover,
                    memCacheHeight: 30,
                    memCacheWidth: 30,
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
                    SizedBox(height: 25),
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
                          : snapshot.data[0].mediaType == 'other'
                              ? GestureDetector(
                                  onTap: () {
                                    launch(
                                      snapshot.data[0].apodSite,
                                      forceWebView: true,
                                      enableJavaScript: true,
                                    );
                                  },
                                  child: Container(
                                    height: 50,
                                    //color: Colors.pink[100],
                                    child: Center(
                                      child: Text(
                                        'This file format is not supported yet :( \nClick here to visit the page',
                                        style: kDetailsTS.copyWith(
                                          color: Colors.red,
                                        ),
                                      ),
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
