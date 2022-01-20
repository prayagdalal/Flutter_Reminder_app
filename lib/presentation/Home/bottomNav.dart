// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_app/controller/navigationBarContoller.dart';
import 'package:reminder_app/presentation/Home/home.dart';
import 'package:reminder_app/presentation/settings/setting.dart';
import 'package:reminder_app/utills/colors.dart';

class LandingPage extends StatelessWidget {
  final TextStyle unselectedLabelStyle = TextStyle(
      color: Colors.white.withOpacity(0.5),
      fontWeight: FontWeight.w500,
      fontSize: 12);

  final TextStyle selectedLabelStyle =
      TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12);

  buildBottomNavigationMenu(context, NavigationController) {
    return Obx(() => SizedBox(
          height: 54,
          child: BottomNavigationBar(
            showUnselectedLabels: true,
            showSelectedLabels: true,
            onTap: NavigationController.changeTabIndex,
            currentIndex: NavigationController.tabIndex.value,
            backgroundColor: green,
            unselectedItemColor: Colors.white.withOpacity(0.5),
            selectedItemColor: Colors.white,
            unselectedLabelStyle: unselectedLabelStyle,
            selectedLabelStyle: selectedLabelStyle,
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
                  backgroundColor: green),
              BottomNavigationBarItem(
                  icon: Container(
                    margin: EdgeInsets.only(bottom: 7),
                    child: Icon(
                      Icons.settings,
                      size: 20.0,
                    ),
                  ),
                  label: 'Settings',
                  backgroundColor: green),
            ],
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    final navigationController = Get.put(NavigationController());
    return Scaffold(
      bottomNavigationBar:
          buildBottomNavigationMenu(context, navigationController),
      body: Obx(() => IndexedStack(
            index: navigationController.tabIndex.value,
            children: [
              Home(),
              SettingPage(),
            ],
          )),
    );
  }
}
