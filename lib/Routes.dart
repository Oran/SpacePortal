import 'package:flutter/material.dart';
import 'package:spaceportal/Constants.dart';
import 'package:spaceportal/Pages/LaunchPage/ServiceProviderViewer/ServiceProviderViewer.dart';
import 'package:spaceportal/Pages/TestPage.dart';
import 'Pages/LaunchPage/LaunchPage.dart';
import 'Pages/APODPage/APODPage.dart';
import 'Pages/ArticlesPage/ArticlesPage.dart';
import 'Pages/HomePage/HomePage.dart';
import 'Pages/LoadingPage/LoadingPage.dart';
import 'Pages/MarsRoverPage/MarsRoverPage.dart';
import 'Pages/NoConnectionPage/NoConnectionPage.dart';

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
