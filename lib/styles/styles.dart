import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myukapp/styles/app_colors.dart';

class AppStyles {
  static TextStyle titleSty = TextStyle(
    fontFamily: 'MerriWeather',
    fontSize: 24.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );
  static TextStyle bodyStyle = TextStyle(
    fontFamily: 'MerriWeather',
    fontSize: 16.sp,
    fontWeight: FontWeight.normal,
    color: AppColors.textColor,
  );
  static TextStyle headingStyle = TextStyle(
    fontFamily: 'MerriWeather',
    fontSize: 20.sp,
    fontWeight: FontWeight.bold,
    color: AppColors.textColor,
  );
  static TextStyle commonTextStyle = TextStyle(
    fontFamily: 'MerriWeather',
    fontSize: 11.sp,
    fontWeight: FontWeight.normal,
    color:AppColors.textColor,
  );
  static TextStyle commonTextStyleBold = TextStyle(
    fontFamily: 'MerriWeather',
    fontSize: 11.sp,
    fontWeight: FontWeight.w900,
    color:AppColors.textColor,
  );
}
