import 'package:SpacePortal/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
// import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class PODContents extends StatelessWidget {
  // final box = Hive.box('cache');

  @override
  Widget build(BuildContext context) {
    var data = Provider.of<Map>(context);
    var orientation = (MediaQuery.of(context).orientation);
    return data['image'] == null
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                Container(
                  height: orientation == Orientation.landscape ? 800.0 : null,
                  padding: EdgeInsets.all(10),
                  // color: Colors.green,
                  child: data['mediaType'] == 'video'
                      ? Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              launch(
                                data['videoURL'],
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
                                    imageUrl: data['image'],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(50.0),
                          child: CachedNetworkImage(
                            imageUrl: data['image'],
                            fit: BoxFit.fill,
                          ),
                        ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                  child: Text(
                    data['title'],
                    style: kTitleDateTS.copyWith(fontSize: 25.0),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                  child: Text(
                    data['date'],
                    style: kTitleDateTS.copyWith(fontSize: 18.0),
                  ),
                ),
                Container(
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
                    child: Text(
                      data['exp'],
                      style: kDetailsTS.copyWith(
                          letterSpacing: 0.7, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}
