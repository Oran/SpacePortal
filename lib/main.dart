import 'dart:io';
import 'package:SpacePortal/Pages/Mobile/home_page.dart';
import 'package:SpacePortal/screens/noConnection.dart';
import 'package:SpacePortal/theme/theme.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:SpacePortal/screens/mars.dart';
import 'package:SpacePortal/screens/nasapod.dart';
import 'package:SpacePortal/screens/spacex.dart';
import 'package:flutter/services.dart';
import 'package:SpacePortal/constants.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox('cache');
  runApp(MyApp());
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
        print('connected');
        return cs.done;
        //print(connectionValue);
      }
    } on SocketException catch (_) {
      print('not connected');
      return cs.notDone;
    }
  }

  @override
  void dispose() async {
    await Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, // forces potrait mode for devices
      DeviceOrientation.portraitDown
    ]);
    return !kIsWeb
        ? MaterialApp(
            //theme: themeData,
            debugShowCheckedModeBanner: false,
            initialRoute: kHome_Page,
            routes: {
              kHome_Page: (context) => HomePage(),
              // kHome_Page: (context) => HomePage(),
              kNASAPod_Page: (context) => NasaPod(),
              kSpaceX_Page: (context) => SpaceX(),
              kMars_Page: (context) => Mars(),
              // kNoConnection_Page: (context) => NoConnectionPage(),
            },
          )
        : FutureBuilder(
            future: checkConnection(),
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.done
                    ? MaterialApp(
                        theme: themeData,
                        debugShowCheckedModeBanner: false,
                        initialRoute: snapshot.data == cs.done
                            ? kHome_Page
                            : kNoConnection_Page,
                        routes: {
                          kHome_Page: (context) => HomePage(),
                          kNASAPod_Page: (context) => NasaPod(),
                          kSpaceX_Page: (context) => SpaceX(),
                          kMars_Page: (context) => Mars(),
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