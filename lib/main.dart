import 'dart:io';
import 'package:SpacePortal/Pages/loading_page.dart';
import 'package:SpacePortal/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:SpacePortal/constants.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:SpacePortal/Pages/home_page.dart';
import 'package:SpacePortal/Pages/mars_page.dart';
import 'package:SpacePortal/Pages/noConnection_page.dart';
import 'package:SpacePortal/Pages/nasapod_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

enum cs {
  done,
  notDone,
  noll,
}

class _MyAppState extends State<MyApp> {
  var connectionValue = cs.noll;

  // This block of code checks if there is an active internet connection.
  Future checkConnection() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        // print('connected');
        return cs.done;
      }
    } on SocketException catch (_) {
      // print('not connected');
      return cs.notDone;
    }
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, // forces potrait mode for devices
      DeviceOrientation.portraitDown
    ]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ));
    return FutureBuilder(
      future: checkConnection(),
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.done
              ? MaterialApp(
                  theme: themeData,
                  debugShowCheckedModeBanner: false,
                  initialRoute: snapshot.data == cs.done
                      ? kLoading_Page
                      : kNoConnection_Page,
                  routes: {
                    kHome_Page: (context) => HomePage(),
                    kNASAPod_Page: (context) => NasaPod(),
                    kMars_Page: (context) => Mars(),
                    kLoading_Page: (context) => LoadingPage(),
                    kNoConnection_Page: (context) => NoConnectionPage(),
                  },
                )
              : Center(
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
}
