import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaceportal/network/apod_network.dart';
import 'package:flutter/material.dart';
import 'package:spaceportal/network/articles_network.dart';
import 'package:spaceportal/network/launch_network.dart';
import 'package:spaceportal/pages/home_page/home_page.dart';
import 'package:spaceportal/providers/providers.dart';
import 'package:spaceportal/utils/functions.dart';
import 'package:theme_provider/theme_provider.dart';

class LoadingPage extends StatelessWidget {
  Future allFutures() async {
    var futures = Future.wait([
      APODData().setDataToCache(),
      ArticleAPI().setDataToCache(),
      LaunchNetwork().setDataToCache(),
      Future.delayed(Duration(milliseconds: 750)),
    ]);
    return futures;
  }

  @override
  Widget build(BuildContext context) {
    var themeId = ThemeProvider.themeOf(context).id;
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness:
          themeId == 'sp_light' ? Brightness.dark : Brightness.light,
      statusBarColor: Colors.transparent,
    ));
    return Consumer(
      builder: (context, ref, child) {
        var futures = ref.watch(loadingPageProvider);
        return futures.when(
          data: (futures) => HomePage(),
          loading: () => Scaffold(
            body: flareLoadingAnimation(),
          ),
          //TODO: Add better error widget.
          error: (e, s) => Scaffold(
            body: Center(
              child: Text('Please Restart the app.'),
            ),
          ),
        );
      },
    );
  }
}
