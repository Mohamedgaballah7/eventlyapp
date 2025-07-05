import 'package:eventlyapproute/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'app_styles.dart';

class AppTheme {
  static final ThemeData lightTheme=ThemeData(
      scaffoldBackgroundColor: AppColors.whiteBgColor,
      textTheme: TextTheme(
        headlineLarge: AppStyles.bold20Black,
      ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.whiteBgColor,
    ),
  );

  static final ThemeData darkTheme=ThemeData(
    scaffoldBackgroundColor: AppColors.primaryDark,
    textTheme: TextTheme(
      headlineLarge: AppStyles.bold20White,
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: AppColors.primaryDark,
    ),
  );

}