import 'package:flutter/material.dart';
import 'package:spaceportal/theme/colors.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:spaceportal/theme/text_theme.dart';

final appThemeLight = AppTheme(
  id: 'sp_light',
  data: ThemeData(
    scaffoldBackgroundColor: AppColors.primaryLight,
    primaryColorLight: AppColors.primaryLight,
    primaryColorDark: AppColors.primaryDark,
    accentColor: AppColors.accentLight,
    iconTheme: IconThemeData(color: AppColors.accentDark),
    textTheme: textThemeLight,
    colorScheme: ColorScheme.light(),
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.primaryLight,
      contentTextStyle: TextStyle(
        color: AppColors.accentLight,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),
  description: '',
);

final appThemeDark = AppTheme(
  id: 'sp_dark',
  data: ThemeData(
    scaffoldBackgroundColor: AppColors.primaryDark,
    primaryColorLight: AppColors.primaryLight,
    primaryColorDark: AppColors.primaryDark,
    accentColor: AppColors.accentDark,
    iconTheme: IconThemeData(color: AppColors.accentDark),
    textTheme: textThemeDark,
    colorScheme: ColorScheme.dark(),
    dialogTheme: DialogTheme(
      backgroundColor: AppColors.primaryDark,
      contentTextStyle: TextStyle(color: AppColors.accentDark),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  ),
  description: '',
);
