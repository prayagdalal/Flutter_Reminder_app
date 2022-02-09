import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../network/session.dart';
import '../presentation/settings/setting.dart';

class SettingController extends GetxController {
  var snoozeflag = true.obs;
  var repeatflag = false.obs;
  var vibrationflag = true.obs;
  var defaultTime = ''.obs;
  var taskTIme = ''.obs;
  // my changes start here =================
  var min5 = true.obs;
  var min10 = false.obs;
  var min15 = false.obs;

  @override
  void onInit() {
    getSessionValue();
    snoozeflag.value = false;
    repeatflag.value = false;
    super.onInit();
  }
  checksnooztype(value) {
    if (value == "5") {
      min5.value = true;
      min10.value = false;
      min15.value = false;
    }
    else if (value == "10") {
      min5.value = false;
      min10.value = true;
      min15.value = false;
    }
    else if (value == "15") {
      min5.value = false;
      min10.value = false;
      min15.value = true;
    }
  }

  //  my chnages end here ==========================
  
  void snoozechange() {
    snoozeflag.value = !snoozeflag.value;
  }

  void repeatChange() {
    repeatflag.value = !repeatflag.value;
  }

  void vibrationchange() {
    vibrationflag.value = !vibrationflag.value;
  }

  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"

    return TimeOfDay.fromDateTime(format.parse(tod));
  }


  getSessionValue() {
    SharedPrefrences.getSession('default_time').then((value) {
      defaultTime.value = value;
      taskTIme.value = value;
    });
  }
}
