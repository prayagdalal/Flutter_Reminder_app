import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/network/session.dart';
import 'package:reminder_app/presentation/settings/setting.dart';

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

  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"
    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  @override
  void onInit() {
    getSessionValue();
    snoozeflag.value = false;
    //  GetStorage().write("defaulttime", "9:00 AM");
    super.onInit();
  }

  getSessionValue() {
    SharedPrefrences.getSession('default_time').then((value) {
      defaultTime.value = value;
    });
  }
}
