import 'package:spaceportal/constants.dart';
import 'package:spaceportal/providers/providers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class APODContents extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var apodProviderData = watch(apodProvider);
    return ListView(
      physics: BouncingScrollPhysics(),
      children: [
        SizedBox(height: 15),
        Container(
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
                  ? InkWell(
                      borderRadius: BorderRadius.circular(20),
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
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.red),
                            borderRadius: BorderRadius.circular(20)),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                apodProviderData.apodSite.toString(),
                                style: kDetailsTS.copyWith(color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'This file format is not supported yet :( \nClick here to visit the page',
                                style: kDetailsTS.copyWith(color: Colors.red),
                              ),
                            ],
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
