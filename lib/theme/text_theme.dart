import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spaceportal/theme/colors.dart';

// ========================== //
// Colors
// ========================== //

final _textColorLight = AppColors.accentLight;
final _textColorDark = AppColors.accentDark;

// ========================== //
// Old Text Theme
// ========================== //

// final _veryLargeTitle = GoogleFonts.lobster(
//   fontSize: 60.0,
//   fontWeight: FontWeight.w800,
//   letterSpacing: 1.2,
// );

// final _cardTitle = GoogleFonts.notoSans(
//   fontSize: 20.0,
//   color: AppColors.accentLight,
//   letterSpacing: 0,
//   fontWeight: FontWeight.w600,
// );

// final _mediumTitle = GoogleFonts.notoSans(
//   fontSize: 25.0,
//   fontWeight: FontWeight.w500,
//   letterSpacing: 0.8,
// );

// final _smallTitle = GoogleFonts.notoSans(
//   fontSize: 18.0,
//   letterSpacing: 0.8,
// );

// final _body = GoogleFonts.notoSans(
//   fontSize: 15.0,
//   letterSpacing: 0.8,
// );

// ============================= //
// TEXT THEME
// ============================= //

final _h1 = GoogleFonts.notoSans(
  fontSize: 96,
  letterSpacing: -1.5,
  fontWeight: FontWeight.w100,
);

final _h2 = GoogleFonts.lobster(
  fontSize: 60,
  letterSpacing: -0.5,
  fontWeight: FontWeight.w100,
);

final _h3 = GoogleFonts.notoSans(
  fontSize: 48,
  letterSpacing: 0,
);

final _h4 = GoogleFonts.roboto(
  fontSize: 34,
  // letterSpacing: 0.25,
  fontWeight: FontWeight.w900,
);

final _h5 = GoogleFonts.roboto(
  fontSize: 27,
  // letterSpacing: -0.5,
  fontWeight: FontWeight.w900,
);

final _h6 = GoogleFonts.notoSans(
  fontSize: 20,
  letterSpacing: 0.15,
  fontWeight: FontWeight.bold,
);

final _sub1 = GoogleFonts.notoSans(
  fontSize: 16,
  letterSpacing: 0.15,
);

final _sub2 = GoogleFonts.notoSans(
  fontSize: 14,
  letterSpacing: 0.1,
);

final _body1 = GoogleFonts.notoSans(
  fontSize: 16,
  letterSpacing: 0.5,
);

final _body2 = GoogleFonts.notoSans(
  fontSize: 14,
  letterSpacing: 0.25,
);

final _button = GoogleFonts.notoSans(
  fontSize: 14,
  letterSpacing: 1.25,
);

final _caption = GoogleFonts.notoSans(
  fontSize: 12,
  letterSpacing: 0.4,
);

final _overline = GoogleFonts.notoSans(
  fontSize: 10,
  letterSpacing: 1.5,
);

final TextTheme textThemeLight = TextTheme(
  headline1: _h1.copyWith(color: _textColorLight),
  headline2: _h2.copyWith(color: _textColorLight),
  headline3: _h3.copyWith(color: _textColorLight),
  headline4: _h4.copyWith(color: _textColorLight),
  headline5: _h5.copyWith(color: _textColorLight),
  headline6: _h6.copyWith(color: _textColorLight),
  subtitle1: _sub1.copyWith(color: _textColorLight),
  subtitle2: _sub2.copyWith(color: _textColorLight),
  bodyText1: _body1.copyWith(color: _textColorLight),
  bodyText2: _body2.copyWith(color: _textColorLight),
  button: _button.copyWith(color: _textColorLight),
  caption: _caption.copyWith(color: _textColorLight),
  overline: _overline.copyWith(color: _textColorLight),
);

final TextTheme textThemeDark = TextTheme(
  headline1: _h1.copyWith(color: _textColorDark),
  headline2: _h2.copyWith(color: _textColorDark),
  headline3: _h3.copyWith(color: _textColorDark),
  headline4: _h4.copyWith(color: _textColorDark),
  headline5: _h5.copyWith(color: _textColorDark),
  headline6: _h6.copyWith(color: _textColorDark),
  subtitle1: _sub1.copyWith(color: _textColorDark),
  subtitle2: _sub2.copyWith(color: _textColorDark),
  bodyText1: _body1.copyWith(color: _textColorDark),
  bodyText2: _body2.copyWith(color: _textColorDark),
  button: _button.copyWith(color: _textColorDark),
  caption: _caption.copyWith(color: _textColorDark),
  overline: _overline.copyWith(color: _textColorDark),
);
