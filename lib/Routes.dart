import 'package:flutter/material.dart';
import 'package:spaceportal/constants.dart';
import 'pages/launch_page/service_provider_viewer/service_provider_viewer.dart';
import 'pages/test_page.dart';
import 'pages/launch_page/launch_page.dart';
import 'pages/apod_page/apod_page.dart';
import 'pages/articles_page/articles_page.dart';
import 'pages/home_page/home_page.dart';
import 'pages/loading_page/loading_page.dart';
import 'pages/mars_rover_page/mars_rover_page.dart';
import 'pages/no_connection_page/no_connection_page.dart';

Map<String, WidgetBuilder> pageRoutes = {
  kHome_Page: (context) => HomePage(),
  kNASAPod_Page: (context) => APODPage(),
  kMars_Page: (context) => MarsRoverPage(),
  kLoading_Page: (context) => LoadingPage(),
  kNoConnection_Page: (context) => NoConnectionPage(),
  kArticles_Page: (context) => ArticlesPage(),
  kLaunch_Page: (context) => LaunchPage(),

  //! DEVELOPMENT ROUTES
  'test': (context) => ServiceProviderViewer(
        url: 'https://ll.thespacedevs.com/2.2.0/agencies/88/?format=json',
        id: 88,
      ),
  'testpage': (context) => TestPage(),
};

// Page Navigation
final rHomePage = HomePage();
final rApodPage = APODPage();
final rMarsPage = MarsRoverPage();
final rLoadingPage = LoadingPage();
final rNoConnectionPage = NoConnectionPage();
final rArticlesPage = ArticlesPage();
final rLaunchPage = LaunchPage();
