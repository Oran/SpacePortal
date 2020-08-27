import 'dart:io';
import 'package:SpacePortal/Pages/Mobile/loading_page.dart';
import 'package:SpacePortal/Pages/Mobile/mars_weather_page.dart';
import 'package:SpacePortal/network/models.dart';
import 'package:SpacePortal/network/network.dart';
import 'package:SpacePortal/theme/theme.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:SpacePortal/constants.dart';

import 'package:provider/provider.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'package:SpacePortal/Pages/Mobile/home_page.dart';
import 'package:SpacePortal/Pages/Mobile/mars_page.dart';
import 'package:SpacePortal/Pages/Mobile/noConnection_page.dart';
import 'package:SpacePortal/Pages/Mobile/nasapod_page.dart';
import 'package:SpacePortal/Pages/Mobile/spacex_page.dart';

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
    return kIsWeb
        ? MultiProvider(
            providers: [
              StreamProvider<FSData>.value(
                value: NasaPODData().getFSData(),
                initialData: FSData(
                  image: kPlaceholderImage,
                ),
              ),
              FutureProvider<List<dynamic>>.value(
                value: SpaceXData().getData(),
                catchError: (context, error) => [],
              ),
              FutureProvider<MarsWeather>.value(
                value: MarsWeatherAPI().getMarsWeather(),
                initialData: MarsWeather(listDays: []),
              ),
            ],
            child: MaterialApp(
              theme: themeData,
              debugShowCheckedModeBanner: false,
              initialRoute: kLoading_Page,
              routes: {
                kHome_Page: (context) => HomePage(),
                kNASAPod_Page: (context) => NasaPod(),
                kSpaceX_Page: (context) => SpaceX(),
                kMars_Page: (context) => Mars(),
                kLoading_Page: (context) => LoadingPage(),
                kNoConnection_Page: (context) => NoConnectionPage(),
              },
            ),
          )
        : FutureBuilder(
            future: checkConnection(),
            builder: (context, snapshot) =>
                snapshot.connectionState == ConnectionState.done
                    ? MultiProvider(
                        providers: [
                          StreamProvider<FSData>.value(
                            value: NasaPODData().getFSData(),
                            initialData: FSData(
                              image: kPlaceholderImage,
                            ),
                          ),
                          FutureProvider<List<dynamic>>.value(
                            value: SpaceXData().getData(),
                            catchError: (context, error) => [],
                          ),
                          FutureProvider<MarsWeather>.value(
                            value: MarsWeatherAPI().getMarsWeather(),
                            initialData: MarsWeather(listDays: []),
                          ),
                        ],
                        child: MaterialApp(
                          theme: themeData,
                          debugShowCheckedModeBanner: false,
                          initialRoute: snapshot.data == cs.done
                              ? kLoading_Page
                              : kNoConnection_Page,
                          routes: {
                            kHome_Page: (context) => HomePage(),
                            kNASAPod_Page: (context) => NasaPod(),
                            kSpaceX_Page: (context) => SpaceX(),
                            kMars_Page: (context) => Mars(),
                            kLoading_Page: (context) => LoadingPage(),
                            kMarsWeather_Page: (context) => MarsWeatherPage(),
                            kNoConnection_Page: (context) => NoConnectionPage(),
                          },
                        ),
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
