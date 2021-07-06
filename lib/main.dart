import 'dart:io';
import 'package:spaceportal/Network/APODNetwork.dart';
import 'package:spaceportal/Network/ArticleNetwork.dart';
import 'package:spaceportal/Network/LaunchNetwork.dart';
import 'package:spaceportal/Routes.dart';
import 'package:spaceportal/Utils/Functions.dart';
import 'package:spaceportal/theme/Theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spaceportal/Constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  WidgetsFlutterBinding.ensureInitialized();
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
        future: Future.wait([
          checkConnection(),
          APODData().openHiveBox(),
          LaunchNetwork().openHiveBox(),
          ArticleAPI().openHiveBox(),
        ]),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return MaterialApp(
                theme: themeData,
                debugShowCheckedModeBanner: false,
                initialRoute:
                    data[0] == cs.done ? kLoading_Page : kNoConnection_Page,
                routes: pageRoutes,
              );
            } else {
              return flareLoading();
            }
          } else {
            return flareLoading();
          }
        });
  }
}
