import 'package:reminder_app/core/app_export.dart';
import 'package:reminder_app/presentation/home_screen/binding/home_binding.dart';
import 'package:reminder_app/presentation/home_screen/bottom_navbar/bottom_navbar.dart';
import 'package:reminder_app/presentation/home_screen/controller/home_controller.dart';
import 'package:reminder_app/presentation/home_screen/home_screen.dart';
import 'package:reminder_app/presentation/reminder_screen/binding/reminder_binding.dart';
import 'package:reminder_app/presentation/reminder_screen/reminder_screen.dart';
import 'package:reminder_app/presentation/search_screen/binding/search_binding.dart';
import 'package:reminder_app/presentation/search_screen/search_screen.dart';
import 'package:reminder_app/presentation/setting_screen/binding/setting_binding.dart';
import 'package:reminder_app/presentation/setting_screen/setting_screen.dart';
import 'package:reminder_app/presentation/splash_screen/splash_screen.dart';

class AppRoutes {
  static String homeScreen = "/home_screen";
  static String searchScreen = "/search_screen";
  static String addReminderScreen = "/addReminder_screen";
  static String settingsScreen = "/settings_screen";
  static String bottomScreen = "/bottom_navbar_screen";
  static String splashScreen = "/splash_screen";

  static List<GetPage> pages = [
    GetPage(
        name: homeScreen, page: () => HomeScreen(), bindings: [HomeBinding()]),
    // GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(
        name: addReminderScreen,
        page: () => AddReminderScreen(),
        bindings: [AddReminderBinding()]),
    GetPage(
        name: settingsScreen,
        page: () => SettingScreen(),
        bindings: [SettingBinding()]),
    GetPage(
        name: searchScreen,
        page: () => SearchScreen(),
        bindings: [SearchBinding()]),
  ];
}
