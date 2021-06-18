import 'package:spaceportal/Constants.dart';
import 'package:spaceportal/Providers/Providers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class APODContents extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var apodProviderData = watch(apodProvider);
    var orientation = (MediaQuery.of(context).orientation);
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        SizedBox(height: 15),
        Container(
          height: orientation == Orientation.landscape ? 800.0 : null,
          padding: EdgeInsets.all(10),
          // color: Colors.green,
          child: apodProviderData.mediaType == 'video'
              ? Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      launch(
                        apodProviderData.videoURL!,
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
                            imageUrl: apodProviderData.videoThumb!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : apodProviderData.mediaType == 'other'
                  ? GestureDetector(
                      onTap: () {
                        launch(
                          apodProviderData.apodSite!,
                          forceWebView: true,
                          enableJavaScript: true,
                        );
                      },
                      child: Container(
                        height: 80,
                        //color: Colors.pink[100],
                        child: Center(
                          child: Text(
                            'This file format is not supported yet :( \nClick here to visit the page',
                            style: kDetailsTS.copyWith(color: Colors.red),
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: CachedNetworkImage(
                          imageUrl: apodProviderData.image!,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
          child: Text(
            apodProviderData.title!,
            style: kTitleDateTS.copyWith(
              fontSize: 25.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
          child: Text(
            apodProviderData.date!,
            style: kTitleDateTS.copyWith(
              fontSize: 18.0,
            ),
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: Text(
              apodProviderData.exp!,
              style: kDetailsTS.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }
}
