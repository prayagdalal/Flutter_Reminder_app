import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class SettingController extends GetxController {
  var snoozeflag = true.obs;
  var vibrationflag = true.obs;
  var defaultTime = ''.obs;

  void snoozechange() {
    snoozeflag.value = !snoozeflag.value;
  }

  void vibrationchange() {
    vibrationflag.value = !vibrationflag.value;
  }

  @override
  void onInit() {
    defaultTime.value = "9:00 AM";
    snoozeflag.value = false;
    //  GetStorage().write("defaulttime", "9:00 AM");
    super.onInit();
  }
}
