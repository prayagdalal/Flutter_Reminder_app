// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks, prefer_is_empty, avoid_print, prefer_const_declarations

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splash_screen_view/SplashScreenView.dart';
import 'package:reminder_app/controller/task_controller.dart';
import 'package:reminder_app/network/session.dart';
import 'package:reminder_app/presentation/Home/bottomNav.dart';
import 'package:reminder_app/utills/colors.dart';
import 'package:reminder_app/utills/notification_service.dart';
import 'controller/add_taskController.dart';
import 'controller/backup_restoreController.dart';
import 'controller/life_cycle_controller.dart';
import 'controller/setting_controller.dart';

final taskController = Get.put(TaskController());
final addTaskController = Get.put(AddTaskController());
final settingController = Get.put(SettingController());
final lifeCycleController = Get.put(LifeCycleController());
final backuprestoreController = Get.put(BackupRestoreController());

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  Get.put(LifeCycleController());
  runApp(const MyApp());
  SharedPrefrences.getSession('default_time').then((value) {
    if (value.isEmpty || value == '') {
      taskController.setSession('10:00 PM');
    }
  });
}

Map<int, Color> color = {
  50: Color.fromRGBO(30, 59, 112, .1),
  100: Color.fromRGBO(30, 59, 112, .2),
  200: Color.fromRGBO(30, 59, 112, .3),
  300: Color.fromRGBO(30, 59, 112, .4),
  400: Color.fromRGBO(30, 59, 112, .5),
  500: Color.fromRGBO(30, 59, 112, .6),
  600: Color.fromRGBO(30, 59, 112, .7),
  700: Color.fromRGBO(30, 59, 112, .8),
  800: Color.fromRGBO(30, 59, 112, .9),
  900: Color.fromRGBO(30, 59, 112, 1),
};
MaterialColor colorCustom = MaterialColor(0xff02953F, color);

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
      home: SplashScreenView(
        navigateRoute: LandingPage(),
        duration: 2000,
        speed: 50,
        imageSize: 130,
        imageSrc: "assets/splash.png",
        text: "Reminder",
        textType: TextType.NormalText,
        textStyle: TextStyle(
          fontSize: 25.0,
          letterSpacing: 1.0,
          color: green,
        ),
        backgroundColor: white,
      ),
    );
  }
}
