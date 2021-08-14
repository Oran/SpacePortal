import 'package:spaceportal/providers/providers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaceportal/utils/functions.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class APODContents extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var apodProviderData = watch(apodProvider);
    var theme = ThemeProvider.themeOf(context);
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
                          style: theme.data.textTheme.bodyText1?.copyWith(
                            color: theme.data.accentColor,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: InteractiveViewer(
                            maxScale: 3,
                            child: CachedNetworkImage(
                              imageUrl: apodProviderData.videoThumb!,
                              fit: BoxFit.cover,
                            ),
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
                                style: theme.data.textTheme.bodyText1?.copyWith(
                                  color: theme.data.errorColor,
                                ),
                              ),
                              SizedBox(height: 10),
                              Text(
                                'This file format is not supported yet :( \nClick here to visit the page',
                                style: theme.data.textTheme.bodyText1?.copyWith(
                                  color: theme.data.errorColor,
                                ),
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
                        boxShadow: showBoxShadow(theme.id),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30.0),
                        child: InteractiveViewer(
                          maxScale: 3,
                          child: CachedNetworkImage(
                            imageUrl: apodProviderData.image!,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
          child: Text(
            apodProviderData.title!,
            style: theme.data.textTheme.headline5,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
          child: Text(
            apodProviderData.date!,
            style: theme.data.textTheme.subtitle1,
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: Text(
              apodProviderData.exp!,
              style: theme.data.textTheme.bodyText1,
            ),
          ),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }
}
