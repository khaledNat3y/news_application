import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news_application/utils/app_colors.dart';

abstract class AppTheme {
  static const TextStyle titleStyle = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.normal
  );
  static const TextStyle sideBarTextStyle = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );
  static const TextStyle tabBarTextStyle = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.normal,
  );
  static const TextStyle articleTitleStyle = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );
  static ThemeData lightTheme = ThemeData(
    drawerTheme: DrawerThemeData(

    ),
    appBarTheme: const AppBarTheme(
      elevation: 5,
      iconTheme: IconThemeData(color: AppColors.white,size: 32),
      backgroundColor: AppColors.primaryColor,
      centerTitle: true,
      shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(60),
              bottomRight: Radius.circular(60),
          )
      ),
    )
  );
}