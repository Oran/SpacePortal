import 'package:flutter/material.dart';
import 'package:spaceportal/Constants.dart';
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
};

final rHomePage = HomePage();
final rApodPage = APODPage();
final rMarsPage = MarsRoverPage();
final rLoadingPage = LoadingPage();
final rNoConnectionPage = NoConnectionPage();
final rArticlesPage = ArticlesPage();
final rLaunchPage = LaunchPage();