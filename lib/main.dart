import 'dart:io';
import 'package:SpacePortal/screens/noConnection_page.dart';
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

class _MyAppState extends State<MyApp> {
  bool connectionValue;

  // This block of code checks if there is an active internet connection.
  void checkConnection() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        setState(() {
          connectionValue = true;
        });
        print(connectionValue);
      }
    } on SocketException catch (_) {
      print('not connected');
      setState(() {
        connectionValue = false;
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
      debugShowCheckedModeBanner: false,
      initialRoute: connectionValue ? knasapod_ID : knoConnection_ID,
      routes: {
        knasapod_ID: (context) => NasaPod(),
        kspaceX_ID: (context) => SpaceX(),
        kmars_ID: (context) => Mars(),
        knoConnection_ID: (context) => NoConnectionPage(),
      },
    );
  }
}
