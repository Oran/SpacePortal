import 'dart:io';
import 'package:spaceportal/network/apod_network.dart';
import 'package:spaceportal/network/articles_network.dart';
import 'package:spaceportal/network/launch_network.dart';
import 'package:spaceportal/routes.dart';
import 'package:spaceportal/utils/functions.dart';
import 'package:spaceportal/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spaceportal/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:spaceportal/utils/generate_blurhash.dart';
import 'package:theme_provider/theme_provider.dart';

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
    return FutureBuilder(
        future: Future.wait([
          checkConnection(),
          APODData().openHiveBox(),
          LaunchNetwork().openHiveBox(),
          ArticleAPI().openHiveBox(),
          BlurH().openHiveBox(),
        ]),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              var data = snapshot.data;
              return ThemeProvider(
                defaultThemeId: 'sp_light',
                loadThemeOnInit: true,
                saveThemesOnChange: true,
                themes: [
                  appThemeLight,
                  appThemeDark,
                ],
                child: ThemeConsumer(
                  child: Builder(
                    builder: (context) {
                      return MaterialApp(
                        theme: ThemeProvider.themeOf(context).data,
                        debugShowCheckedModeBanner: false,
                        initialRoute: data[0] == cs.done
                            ? kLoading_Page
                            : kNoConnection_Page,
                        routes: pageRoutes,
                      );
                    },
                  ),
                ),
              );
            } else {
              return flareLoadingAnimation();
            }
          } else {
            return flareLoadingAnimation();
          }
        });
  }
}
