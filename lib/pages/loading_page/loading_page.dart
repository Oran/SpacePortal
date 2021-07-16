import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spaceportal/network/apod_network.dart';
import 'package:flutter/material.dart';
import 'package:spaceportal/network/articles_network.dart';
import 'package:spaceportal/network/launch_network.dart';
import 'package:spaceportal/pages/home_page/home_page.dart';
import 'package:spaceportal/providers/providers.dart';
import 'package:spaceportal/utils/functions.dart';

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
    return Consumer(
      builder: (context, watch, child) {
        var futures = watch(loadingPageProvider);
        return futures.when(
          data: (futures) => HomePage(),
          loading: () => Scaffold(
            body: flareLoadingAnimation(),
          ),
          //TODO: Add better error widget.
          error: (e, s) => Text('error'),
        );
      },
    );
  }
}
