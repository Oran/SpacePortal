import 'dart:io';
import 'package:SpacePortal/screens/noConnection.dart';
import 'package:SpacePortal/theme/theme.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:SpacePortal/screens/mars.dart';
import 'package:SpacePortal/screens/nasapod.dart';
import 'package:SpacePortal/screens/spacex.dart';
import 'package:flutter/services.dart';
import 'constants.dart';
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
    return MaterialApp(
      theme: themeData,
      debugShowCheckedModeBanner: false,
      initialRoute: knasapod_ID,
      routes: {
        knasapod_ID: (context) => NasaPod(),
        kspaceX_ID: (context) => SpaceX(),
        kmars_ID: (context) => Mars(),
        knoConnection_ID: (context) => NoConnectionPage(),
      },
    );
  }
}

// FutureBuilder(
//       future: Future.delayed(Duration(seconds: 5)),
//       builder: (context, snapshot) =>
//           snapshot.connectionState == ConnectionState.done
//               ? MaterialApp(
//                   theme: themeData,
//                   debugShowCheckedModeBanner: false,
//                   initialRoute: connectionValue == cs.done
//                       ? knasapod_ID
//                       : knoConnection_ID,
//                   routes: {
//                     knasapod_ID: (context) => NasaPod(),
//                     kspaceX_ID: (context) => SpaceX(),
//                     kmars_ID: (context) => Mars(),
//                     knoConnection_ID: (context) => NoConnectionPage(),
//                   },
//                 )
//               : Center(
//                   child: Container(
//                     height: 400.0,
//                     width: 400.0,
//                     child: FlareActor(
//                       'assets/animations/space.flr',
//                       animation: 'Untitled',
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                 ),
//     );
