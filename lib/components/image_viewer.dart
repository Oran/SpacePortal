import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:SpacePortal/constants.dart';

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
        flexibleSpace: Container(decoration: kAppbarBoxDecoration),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10.0),
            child: Hero(
              tag: 'tag' + index.toString(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(25.0),
                child: CachedNetworkImage(imageUrl: list),
              ),
            ),
          ),
          RaisedButton(
            child: Text('download'),
            onPressed: () {
              launch(list);
              //TODO: Implement Image download feature.
            },
          )
        ],
      ),
    );
  }
}
