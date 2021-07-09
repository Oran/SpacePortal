import 'dart:ui';
import 'package:spaceportal/providers/providers.dart';
import 'package:spaceportal/utils/functions.dart';
import 'package:spaceportal/constants.dart';
import 'package:spaceportal/widgets/fadein_appbar.dart';
import 'package:spaceportal/pages/apod_page/components/apod_container.dart';
import 'package:spaceportal/pages/apod_page/components/apod_viewer.dart';
import 'package:spaceportal/pages/apod_page/components/download_button.dart';
import 'package:spaceportal/theme/theme.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
              iconTheme: IconThemeData(
                color: snapshot.data < 127 ? Colors.white : Colors.black,
              ),
              title: Container(
                child: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  centerTitle: true,
                  title: Text(
                    'Picture of the day',
                    style: kTitleDateTS.copyWith(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: snapshot.data < 127 ? Colors.white : Colors.black,
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
                    data: (data) => FadeInAppBar(value: data),
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
                InkWell(
                  onTap: () {
                    _openDialog(context);
                  },
                  borderRadius: BorderRadius.circular(180),
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Center(
                      child: Icon(
                        Icons.event_rounded,
                        color:
                            snapshot.data < 127 ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                ),
                DownloadButton(
                  snapshotData: snapshot.data,
                  imageUrl: apodProviderData.hdUrl,
                  mediaType: apodProviderData.mediaType,
                ),
              ],
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
