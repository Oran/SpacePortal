import 'package:SpacePortal/constants.dart';
import 'package:SpacePortal/network/network.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class NasaPODViewer extends StatefulWidget {
  NasaPODViewer({
    this.title = '',
    this.date = '',
    this.exp = '',
    this.image = kPlaceholderImage,
    this.mediaType = '',
    this.testf = '',
    this.videoURL = '',
  });
  final String title;
  final String date;
  final String image;
  final String mediaType;
  final String exp;
  final String testf;
  final String videoURL;

  @override
  _NasaPODViewerState createState() => _NasaPODViewerState();
}

class _NasaPODViewerState extends State<NasaPODViewer> {
  OldNasaPodData oldData = OldNasaPodData();
  var newData;

  Future getData() async {
    oldData.setURL(widget.date);
    var ddata = await oldData.getOldNasaPodData();
    return ddata;
  }

  @override
  void initState() {
    super.initState();
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
              elevation: 0,
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
                      child: snapshot.data.mediaType == 'video'
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8.0),
                              child: GestureDetector(
                                onTap: () {
                                  launch(
                                    snapshot.data.videoURL,
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
                                        imageUrl: snapshot.data.videoThumb,
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
                                  imageUrl: snapshot.data.image,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                      child: Text(
                        snapshot.data.title,
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
                        snapshot.data.date,
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
                          snapshot.data.exp,
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
