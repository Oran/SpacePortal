import 'package:flutter/material.dart';
import 'package:SpacePortal/constants.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

//TODO: Still in development
class ImageViewer extends StatelessWidget {
  ImageViewer({this.index, this.list});

  final list;
  final index;

  @override
  Widget build(BuildContext context) {
    var index = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        elevation: 0,
        actions: [
          GestureDetector(
            //TODO: Implement Image download function
            onTap: () {
              launch(
                list,
                // forceWebView: true,
                // enableJavaScript: true,
              );
            },
            child: Container(
              height: 60.0,
              width: 60.0,
              color: kPrimaryWhite,
              child: Icon(
                Icons.get_app,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Hero(
          tag: 'tag' + index.toString(),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30.0),
            child: CachedNetworkImage(imageUrl: list),
          ),
        ),
      ),
    );
  }
}
