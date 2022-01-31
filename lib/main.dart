// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:reminder_app/presentation/Home/bottomNav.dart';
import 'package:reminder_app/utills/notification_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(const MyApp());
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
      home: LandingPage(),
    );
  }
}
