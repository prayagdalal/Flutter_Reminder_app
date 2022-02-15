import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:reminder_app/core/app_export.dart';
import 'package:reminder_app/core/utils/color_constant.dart';
import 'package:reminder_app/presentation/home_screen/controller/home_controller.dart';
import 'package:reminder_app/presentation/home_screen/home_screen.dart';
import 'package:reminder_app/presentation/home_screen/widgets/home_body.dart';
import 'package:reminder_app/theme/app_style.dart';

class BottomNavBar extends GetWidget<HomeScreenController> {
  const BottomNavBar({Key? key}) : super(key: key);

  // Function(int) callback;

  // BottomNavBar({required this.callback});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 54,
        child: BottomNavigationBar(
          showUnselectedLabels: true,
          showSelectedLabels: true,
          onTap: (val) => {controller.tabIndex.value = val},
          // onTap: callback,
          currentIndex: 0,
          backgroundColor: ColorConstant.green,
          unselectedItemColor: ColorConstant.white,
          selectedItemColor: ColorConstant.white,
          unselectedLabelStyle: AppStyle.bottomnavbarunselectedLabelStyle,
          selectedLabelStyle: AppStyle.bottomNavbarselectedLabelStyle,
          items: [
            BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  child: Icon(
                    Icons.alarm,
                    size: 20.0,
                  ),
                ),
                label: 'Reminder',
                backgroundColor: ColorConstant.green),
            BottomNavigationBarItem(
                icon: Container(
                  margin: EdgeInsets.only(bottom: 7),
                  child: Icon(
                    Icons.settings,
                    size: 20.0,
                  ),
                ),
                label: 'Settings',
                backgroundColor: ColorConstant.green),
          ],
        ));
  }
}
