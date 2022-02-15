import 'package:flutter/material.dart';
import 'package:reminder_app/core/utils/color_constant.dart';
import 'package:reminder_app/core/utils/image_constant.dart';
import 'package:reminder_app/network/notification_service.dart';
import 'package:reminder_app/presentation/home_screen/bottom_navbar/bottom_navbar.dart';
import 'package:reminder_app/presentation/home_screen/home_screen.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'core/app_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Reminde App',
      initialBinding: InitialBindings(),
      getPages: AppRoutes.pages,
      initialRoute: AppRoutes.homeScreen,
    );
  }
}
