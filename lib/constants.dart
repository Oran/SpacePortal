import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Routes for navigation
const String kHome_Page = 'home_page';
const String kNASAPod_Page = 'nasapod_page';
const String kSpaceX_Page = 'spacex_page';
const String kMars_Page = 'mars_page';
const String kNoConnection_Page = 'noConnection_page';

// New Colors
const Color kPrimaryWhite = Colors.white;
const Color kPrimaryBlack = Colors.black;
// const Color kPrimaryDarkPurple = Color(0xFF1E1930);
// const Color kAccentDogwoodRose = Color(0xFFCC296C);
// const Color kAccentDarkCornflowerBlue = Color(0xFF25418A);
// const Color kAccentPlumWeb = Color(0xFFE19EDD);
// const Color kAccentWisteria = Color(0xFFAB95D7);
//const Color kAccentAmber = Colors.amber;
const Color kAccentSkyBlue = Color(0xFF00e9f2);

// Theming for the app
const Color kAccentColor = kPrimaryBlack;
const Color kDrawerColor = kPrimaryWhite;
const Color kIconColor = kPrimaryWhite;
const Color kAppBarColor = kPrimaryWhite;
const Color kDropDownButtonColor = kPrimaryBlack;

//Color Gradient
BoxDecoration kAppbarBoxDecoration = BoxDecoration(
  gradient: kGradient,
);

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
  fontSize: 18.0,
  color: kPrimaryBlack,
);

TextStyle kDetailsTS = GoogleFonts.notoSans(
  fontSize: 15.0,
  color: kPrimaryBlack,
);
