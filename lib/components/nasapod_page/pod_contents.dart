import 'package:SpacePortal/constants.dart';
import 'package:SpacePortal/network/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PodContents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = Provider.of<FSData>(context);
    var orientation = (MediaQuery.of(context).orientation);
    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          height: orientation == Orientation.landscape ? 800.0 : null,
          padding: EdgeInsets.all(10),
          // color: Colors.green,
          child: data.mediaType == 'video'
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      launch(
                        data.videoURL,
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
                            imageUrl: data.image,
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
                        offset:
                            Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30.0),
                    child: CachedNetworkImage(
                      imageUrl: data.image,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
          child: Text(
            data.title,
            style: kTitleDateTS.copyWith(
              fontSize: 25.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
          child: Text(
            data.date,
            style: kTitleDateTS.copyWith(
              fontSize: 18.0,
            ),
          ),
        ),
        Container(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: Text(
              data.exp,
              style: kDetailsTS.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0),
      ]),
    );
  }
}
