import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//Routes for navigation
const String knasapod_ID = 'nasapod';
const String kspaceX_ID = 'spacex';
const String kmars_ID = 'mars';
const String knoConnection_ID = 'noConnection';

//Color palette for the app
const Color kPrimarySkyBlue = Color(0xff026599);
const Color kAccent60Blue = Color(0xff024c74);
const Color kAccent40Blue = Color(0xff02334e);
const Color kAccent20Blue = Color(0xff021a28);
const Color kAccentdarkBlue = Color(0xff010102);
const Color kPrimaryWhite = Colors.white;
const Color kPrimaryBlack = Colors.black;

// New Colors
const Color kPrimaryDarkPurple = Color(0xFF1E1930);
const Color kAccentDogwoodRose = Color(0xFFCC296C);
const Color kAccentDarkCornflowerBlue = Color(0xFF25418A);
const Color kAccentPlumWeb = Color(0xFFE19EDD);
const Color kAccentWisteria = Color(0xFFAB95D7);

//Color Gradients
const List<Color> kGradientSpaceBlue = [
  Color(0xff026599),
  Color(0xff055d8e),
  Color(0xff085483),
  Color(0xff0a4c79),
  Color(0xff0d476e),
  Color(0xff0f4164),
  Color(0xff103b5b),
  Color(0xff113552),
  Color(0xff122e49),
  Color(0xff122842),
  Color(0xff11213a),
  Color(0xff101a33),
  Color(0xff10182b),
  Color(0xff0f1624),
  Color(0xff0e131d),
  Color(0xff0d1016),
  Color(0xff0b0c10),
  Color(0xff08080b),
  Color(0xff050506),
  Color(0xff010102),
];

//TextStyle
TextStyle kTitleDateTS = GoogleFonts.notoSans(
  fontSize: 18.0,
  color: kAccentWisteria,
);

TextStyle kDetailsTS = GoogleFonts.notoSans(
  fontSize: 15.0,
  color: kAccentWisteria,
);
