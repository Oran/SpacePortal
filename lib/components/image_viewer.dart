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
        backgroundColor: kAppBarColor,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              child: Hero(
                tag: 'tag' + index.toString(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30.0),
                  child: CachedNetworkImage(imageUrl: list),
                ),
              ),
            ),
            SizedBox(height: 10.0),
            GestureDetector(
              //TODO: Implement Image download function
              onTap: () {},
              child: Container(
                height: 60.0,
                width: 60.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: kAccentColor),
                    color: kAccentColor),
                child: Icon(
                  Icons.get_app,
                  color: kIconColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
