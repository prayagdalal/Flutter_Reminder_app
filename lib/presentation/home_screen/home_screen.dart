import 'package:flutter/material.dart';
import 'package:reminder_app/core/app_export.dart';
import 'package:reminder_app/core/utils/color_constant.dart';
import 'package:reminder_app/presentation/home_screen/bottom_navbar/bottom_navbar.dart';
import 'package:reminder_app/presentation/home_screen/controller/home_controller.dart';

import 'package:reminder_app/theme/app_style.dart';

class HomeScreen extends GetWidget<HomeScreenController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Obx(() => controller.changeTabIndex())),
      // body: Container(child: Text("ajkhsd")),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}
