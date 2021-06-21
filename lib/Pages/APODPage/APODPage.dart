import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:spaceportal/Providers/Providers.dart';
import 'package:spaceportal/Utils/Functions.dart';
import 'package:spaceportal/Pages/APODPage/Components/APODViewer.dart';
import 'package:spaceportal/Pages/APODPage/Components/APODContainer.dart';
import 'package:spaceportal/Constants.dart';
import 'package:spaceportal/Providers/Providers.dart';
import 'package:spaceportal/theme/Theme.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaceportal/Pages/APODPage/Components/DownloadButton.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

enum wb { white, black }

// ignore: must_be_immutable
class APODPage extends ConsumerWidget {
  wb? bulll;

  _openDialog(BuildContext context) {
    return showDatePicker(
      context: context,
      lastDate: DateTime.now(),
      firstDate: DateTime.parse('2000-01-01'),
      initialDate: DateTime.now(),
      builder: (context, child) {
        return Theme(
          data: themeData.copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.black,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    ).then((value) => {
          parseDates(value?.toString() ?? DateTime.now().toString()) ==
                  parseDates(DateTime.now().toString())
              ? ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Dates are the same',
                      style: kDetailsTS.copyWith(color: Colors.white),
                    ),
                    duration: Duration(seconds: 2),
                  ),
                )
              : Navigator.push(
                  context,
                  routeTo(
                    APODViewer(
                      date: parseDates(
                          value?.toString() ?? DateTime.now().toString()),
                    ),
                  ),
                ),
        });
  }

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    var apodProviderData = watch(apodProvider);
    return FutureBuilder(
      future: checkImgColor(apodProviderData.image!),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: kPrimaryWhite,
              title: Container(
                child: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  centerTitle: true,
                  title: AnimatedDefaultTextStyle(
                    style: kTitleDateTS.copyWith(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: snapshot.data < 127 ? Colors.white : Colors.black,
                    ),
                    duration: Duration(milliseconds: 250),
                    child: Text(
                      'Picture Of The Day',
                    ),
                  ),
                ),
              ),
              // flexibleSpace: ClipRRect(
              //   child: ImageFiltered(
              //     imageFilter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              //     child: Container(
              //       height: (MediaQuery.of(context).size.height),
              //       width: (MediaQuery.of(context).size.width),
              //       child: CachedNetworkImage(
              //         imageUrl: apodProviderData.mediaType == 'video'
              //             ? apodProviderData.videoThumb!
              //             : apodProviderData.image!,
              //         fit: BoxFit.cover,
              //         memCacheHeight: 30,
              //         memCacheWidth: 30,
              //       ),
              //     ),
              //   ),
              // ),
              flexibleSpace: Consumer(
                builder: (context, watch, child) {
                  var provider = watch(blurhashProvider(
                    apodProviderData.mediaType == 'video'
                        ? apodProviderData.videoThumb!
                        : apodProviderData.image!,
                  ));
                  return provider.when(
                    data: (value) => BlurHash(
                      hash: value.toString(),
                    ),
                    loading: () => Container(),
                    error: (e, s) {
                      print(e);
                      print(s);
                      return Container(
                        color: Colors.grey[100],
                      );
                    },
                  );
                },
              ),
              actions: [
                DownloadButton(
                  snapshotData: snapshot.data,
                  imageUrl: apodProviderData.hdUrl,
                  mediaType: apodProviderData.mediaType,
                ),
              ],
              leading: InkWell(
                onTap: () {
                  _openDialog(context);
                },
                borderRadius: BorderRadius.circular(40),
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 250),
                  child: Icon(
                    Icons.tune_rounded,
                    color: snapshot.data < 127 ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            body: APODContents(),
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
