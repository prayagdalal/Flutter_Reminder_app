import 'package:flutter/material.dart';
import 'package:reminder_app/core/utils/color_constant.dart';
import 'package:reminder_app/presentation/setting_screen/widget/setting_display.dart';
import 'package:reminder_app/theme/app_style.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffeeeeee),
        appBar: AppBar(
          elevation: 3,
          backgroundColor: ColorConstant.green,
          title: Text(
            'Settings',
            style: AppStyle.appBarTitle,
          ),
        ),
        body: SettingBody());
  }
}
