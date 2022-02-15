import 'package:flutter/material.dart';
import 'package:reminder_app/core/utils/color_constant.dart';
import 'package:reminder_app/core/app_export.dart';

class AppDecoration {
  static BoxDecoration tabBarBoxDecoration = BoxDecoration(
    color: ColorConstant.green,
    shape: BoxShape.rectangle,
    borderRadius: BorderRadius.circular(12),
  );

  static BoxDecoration dropDownBorder = BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    border: Border.all(
        color: ColorConstant.green, style: BorderStyle.solid, width: 0.5),
  );

  static BoxDecoration repeatTypeBorder = BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    border: Border.all(
        color: ColorConstant.green, style: BorderStyle.solid, width: 0.5),
  );

  static RoundedRectangleBorder cardRoundedRectangleBorder =
      RoundedRectangleBorder(
    side: BorderSide(color: (Colors.grey[350]!), width: 0.7),
    borderRadius: BorderRadius.circular(6.0),
  );

  static BoxDecoration OkButton = BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    border: Border.all(color: ColorConstant.green),
  );

  static InputDecoration textfieldDecoration = InputDecoration(
    filled: true,
    fillColor: ColorConstant.white,
    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(color: ColorConstant.green, width: 0.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(color: ColorConstant.green, width: 0.5),
    ),
  );
}
