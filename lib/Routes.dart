import 'package:flutter/material.dart';
import 'package:spaceportal/Constants.dart';

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
};
