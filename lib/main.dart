import 'dart:io';
import 'package:SpacePortal/screens/noConnection_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:SpacePortal/screens/mars.dart';
import 'package:SpacePortal/screens/nasapod.dart';
import 'package:SpacePortal/screens/spacex.dart';
import 'package:flutter/services.dart';
import 'constants.dart';

void main() {
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
  void checkConnection() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        setState(() {
          connectionValue = cs.done;
        });
        print(connectionValue);
      }
    } on SocketException catch (_) {
      print('not connected');
      setState(() {
        connectionValue = cs.notDone;
      });
      print(connectionValue);
    }
  }

  @override
  void initState() {
    checkConnection();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp, // forces potrait mode for devices
      DeviceOrientation.portraitDown
    ]);
    return FutureBuilder(
      future: Future.delayed(Duration(seconds: 5)),
      builder: (context, snapshot) =>
          snapshot.connectionState == ConnectionState.done
              ? MaterialApp(
                  debugShowCheckedModeBanner: false,
                  initialRoute: connectionValue == cs.done
                      ? knasapod_ID
                      : knoConnection_ID,
                  routes: {
                    knasapod_ID: (context) => NasaPod(),
                    kspaceX_ID: (context) => SpaceX(),
                    kmars_ID: (context) => Mars(),
                    knoConnection_ID: (context) => NoConnectionPage(),
                  },
                )
              : Center(child: CircularProgressIndicator()),
    );
  }
}

// MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: connectionValue == cs.done || connectionValue != cs.noll ? knasapod_ID : knoConnection_ID,
//       routes: {
//         knasapod_ID: (context) => NasaPod(),
//         kspaceX_ID: (context) => SpaceX(),
//         kmars_ID: (context) => Mars(),
//         knoConnection_ID: (context) => NoConnectionPage(),
//       },
//     );
