import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder_app/core/utils/color_constant.dart';

class AppStyle {
  static TextStyle cardTitleTextStyle = TextStyle(
      fontSize: 18, color: ColorConstant.black, fontWeight: FontWeight.w600);

  static TextStyle cardDescrtiptionTextStyle = TextStyle(
      fontSize: 13, color: ColorConstant.black, fontStyle: FontStyle.italic);

  static TextStyle cardEventTextStyle =
      TextStyle(fontSize: 13, color: ColorConstant.black);

  static TextStyle appBarTitle = TextStyle(
      fontSize: 18, color: ColorConstant.white, fontWeight: FontWeight.w800);

  static TextStyle alarmDateTime = TextStyle(
      fontSize: 16, color: ColorConstant.black, fontWeight: FontWeight.w700);

  static TextStyle backupStyle = TextStyle(
      fontSize: 18, color: ColorConstant.green, fontWeight: FontWeight.bold);

  static TextStyle bottomNavbarselectedLabelStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  static TextStyle popupCategorySearch =
      TextStyle(fontWeight: FontWeight.w600, fontSize: 16);

  static TextStyle categoryStyle = TextStyle(
    color: Colors.black,
    fontWeight: FontWeight.w500,
  );

  static TextStyle dialyTypeTextStyle =
      TextStyle(fontSize: 13, color: ColorConstant.white);

  static TextStyle dialyTypePopUpTextStyle =
      TextStyle(color: ColorConstant.white, fontWeight: FontWeight.bold);

  static TextStyle bottomnavbarunselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);
}
