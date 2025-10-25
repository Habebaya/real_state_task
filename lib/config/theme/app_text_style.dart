import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constant/app_strings.dart';
import 'app_color.dart';

class TextStyles {
  TextStyles._();

  static FontWeight veryLightFontWeight = FontWeight.w300;
  static FontWeight lightFontWeight = FontWeight.w400;
  static FontWeight normalFontWeight = FontWeight.normal; //400
  static FontWeight mediumFontWeight = FontWeight.w500;
  static FontWeight semiBoldFontWeight = FontWeight.w600;
  static FontWeight boldFontWeight = FontWeight.w700;
  static FontWeight extraBoldFontWeight = FontWeight.w800;

  static String cairoFontFamily = AppStrings.robotoFontFamily;

  static TextStyle light12MediumBlack(BuildContext context) {
    return TextStyle(
      fontFamily: cairoFontFamily,
      color: AppColors.mediumBlackColor,
      fontSize: 12.sp,
      fontWeight: lightFontWeight,
    );
  }

  static TextStyle light12LightGray(BuildContext context) {
    return TextStyle(
      fontFamily: cairoFontFamily,
      color: AppColors.lightGray,
      fontSize: 12.sp,
      fontWeight: lightFontWeight,
    );
  }

  static TextStyle normal14MediumBlack(BuildContext context) {
    return TextStyle(
      fontFamily: cairoFontFamily,

      color: AppColors.mediumBlackColor,
      fontSize: 14.sp,
      fontWeight: normalFontWeight,
    );
  }

  static TextStyle normal13darkNavy(BuildContext context) {
    return TextStyle(
      fontFamily: cairoFontFamily,

      color: AppColors.darkNavyColor,
      fontSize: 13.sp,
      fontWeight: lightFontWeight,
    );
  }

  static TextStyle normal14darkGray(BuildContext context) {
    return TextStyle(
      fontFamily: cairoFontFamily,
      color: AppColors.darkGray,
      fontSize: 14.sp,
      fontWeight: lightFontWeight,
    );
  }

  static TextStyle bold16Primary(BuildContext context) {
    return TextStyle(
      fontFamily: cairoFontFamily,
      color: AppColors.primaryColor,
      fontSize: 18.sp,
      fontWeight: boldFontWeight,
    );
  }
}
