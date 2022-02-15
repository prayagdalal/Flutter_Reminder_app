import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/core/app_export.dart';
import 'package:reminder_app/presentation/setting_screen/controller/backup_restore_controller.dart';

class SettingScreenController extends GetxController {
  var defaultTime = ''.obs;
  var snoozeflag = true.obs;
  var repeatflag = false.obs;
  var vibrationflag = true.obs;
  var taskTime = ''.obs;

  Rx<backupRestoreController> backController = backupRestoreController().obs;

  @override
  void onInit() {
    getSessionValue();
    super.onInit();
  }

  TimeOfDay stringToTimeOfDay(String tod) {
    final format = DateFormat.jm(); //"6:00 AM"

    return TimeOfDay.fromDateTime(format.parse(tod));
  }

  getSessionValue() {
    SharedPrefrences.getSession('default_time').then((value) {
      defaultTime.value = value;
      taskTime.value = value;
    });
  }

  TimeOfDay selectetime = TimeOfDay.now();
  selectTime(BuildContext ctx) async {
    final TimeOfDay? picked = await showTimePicker(
        context: ctx, initialTime: stringToTimeOfDay(defaultTime.value));

    if (picked != null && picked != selectetime) {
      DateTime tempDate = DateFormat("hh:mm")
          .parse(picked.hour.toString() + ":" + picked.minute.toString());
      var dateFormat = DateFormat("h:mm a");
      defaultTime.value = dateFormat.format(tempDate);
      // print(settingController.defaultTime.value);
      SharedPrefrences.setSession("SettingsKey", dateFormat.format(tempDate));
    }
  }
}
