import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Routes for navigation
const String kHome_Page = 'home_page';
const String kNASAPod_Page = 'nasapod_page';
const String kSpaceX_Page = 'spacex_page';
const String kMars_Page = 'mars_page';
const String kNoConnection_Page = 'noConnection_page';
const String kLoading_Page = 'loading_page';

// New Colors
const Color kPrimaryWhite = Colors.white;
const Color kPrimaryBlack = Colors.black;
const Color kAccentSkyBlue = Color(0xFF00e9f2);

// Theming for the app
const Color kAccentColor = kPrimaryBlack;
const Color kDrawerColor = kPrimaryWhite;
const Color kIconColor = kPrimaryWhite;
const Color kAppBarColor = kPrimaryWhite;
const Color kDropDownButtonColor = kPrimaryBlack;

//Color Gradient
Gradient kGradient = LinearGradient(
  colors: kcolorGradient,
  begin: Alignment.centerRight,
  end: Alignment.centerLeft,
);

List<Color> kcolorGradient = [
  Color(0xFF0d53cc),
  Color(0xFF00b1ea),
  Color(0xFF00e9f2),
  Color(0xFF00facf),
  Color(0xFF20ea7a),
];

//TextStyle
TextStyle kTitleDateTS = GoogleFonts.notoSans(
    fontSize: 18.0, color: kPrimaryBlack, letterSpacing: 0.8);

TextStyle kDetailsTS = GoogleFonts.notoSans(
    fontSize: 15.0, color: kPrimaryBlack, letterSpacing: 0.8);

TextStyle kMarsStatsStyle = GoogleFonts.notoSans(
    fontSize: 15.0,
    color: kPrimaryBlack,
    fontWeight: FontWeight.bold,
    letterSpacing: 0.8);

TextStyle kTitleLargeTS = GoogleFonts.notoSans(
    fontSize: 40.0, fontWeight: FontWeight.w600, letterSpacing: 0.8);

TextStyle kCardTS = GoogleFonts.notoSans(
  fontSize: 40.0,
  color: Colors.white,
  letterSpacing: 1,
  fontWeight: FontWeight.w900,
  shadows: [
    Shadow(
      color: Colors.black,
      blurRadius: 30,
      offset: Offset(0, 0),
    ),
    // Shadow(
    //   color: Colors.black,
    //   blurRadius: 40,
    //   offset: Offset(0, 0),
    // ),
    // Shadow(
    //   color: Colors.black,
    //   blurRadius: 70,
    //   offset: Offset(0, 0),
    // ),
  ],
);
