import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:spaceportal/theme/colors.dart';

final TextTheme textThemeLight = TextTheme(
  headline1: GoogleFonts.lobster(
    fontSize: 60.0,
    color: AppColors.accentLight,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.2,
  ),
);

final TextTheme textThemeDark = TextTheme(
  headline1: GoogleFonts.lobster(
    fontSize: 60.0,
    color: AppColors.accentDark,
    fontWeight: FontWeight.w800,
    letterSpacing: 1.2,
  ),
);
