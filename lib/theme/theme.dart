import 'package:flutter/material.dart';
import 'package:spaceportal/theme/colors.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:spaceportal/theme/text_theme.dart';

final appThemeLight = AppTheme(
  id: 'sp_light',
  data: ThemeData(
    // Base Colors
    scaffoldBackgroundColor: AppColors.primaryLight,
    primaryColorLight: AppColors.primaryLight,
    primaryColorDark: AppColors.primaryDark,
    primaryColor: AppColors.primaryLight,
    accentColor: AppColors.accentLight,
    errorColor: AppColors.error,
    primaryColorBrightness: Brightness.light,
    cardColor: AppColors.primaryLight,

    //Appbar
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryLight,
      elevation: 0,
      centerTitle: true,
      actionsIconTheme: IconThemeData(
        color: AppColors.accentLight,
      ),
    ),

    // IconTheme
    iconTheme: IconThemeData(color: AppColors.accentLight),

    // TextTheme
    textTheme: textThemeLight,

    // ColorScheme
    colorScheme: ColorScheme.light(
      primary: AppColors.accentLight,
      onPrimary: Colors.white,
      onSurface: AppColors.accentLight,
    ),

    // SnackBar Theme
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.accentLight,
      contentTextStyle: textThemeLight.bodyText1?.copyWith(
        color: AppColors.accentLight,
      ),
    ),

    //Dialog Theme
    dialogBackgroundColor: AppColors.primaryLight,
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.primaryLight,
      contentTextStyle: TextStyle(
        color: AppColors.accentDark,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    // Button Themes
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          AppColors.accentLight,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(),
    ),
  ),
  description: '',
);

final appThemeDark = AppTheme(
  id: 'sp_dark',
  data: ThemeData(
    // Base Colors
    scaffoldBackgroundColor: AppColors.primaryDark,
    primaryColorLight: AppColors.primaryLight,
    primaryColorDark: AppColors.primaryDark,
    primaryColor: AppColors.primaryDark,
    accentColor: AppColors.accentDark,
    errorColor: AppColors.error,
    primaryColorBrightness: Brightness.dark,
    cardColor: AppColors.cardDark,

    //Appbar
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryDark,
      elevation: 0,
      centerTitle: true,
      actionsIconTheme: IconThemeData(
        color: AppColors.accentDark,
      ),
    ),

    // IconTheme
    iconTheme: IconThemeData(color: AppColors.accentDark),

    // TextTheme
    textTheme: textThemeDark,

    // ColorScheme for Dialogs
    colorScheme: ColorScheme.dark(
      primary: AppColors.accentDark,
      onPrimary: Colors.black,
      onSurface: AppColors.accentDark,
    ),

    // Snackbar
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.accentDark,
      contentTextStyle: textThemeLight.bodyText1?.copyWith(
        color: AppColors.accentLight,
      ),
    ),

    // Dialog Theme
    dialogBackgroundColor: AppColors.primaryDark,
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.primaryDark,
      contentTextStyle: TextStyle(color: AppColors.accentDark),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),

    // ElevatedButton Theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          AppColors.accentDark,
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(),
    ),
  ),
  description: '',
);
