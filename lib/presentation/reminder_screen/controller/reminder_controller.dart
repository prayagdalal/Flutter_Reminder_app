import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/data/apiClient/api_client.dart';
import 'package:reminder_app/data/models/model.dart';
import 'package:reminder_app/presentation/reminder_screen/widgets/daily.dart';
import 'package:reminder_app/presentation/reminder_screen/widgets/hourly.dart';
import 'package:reminder_app/presentation/reminder_screen/widgets/minute.dart';
import 'package:reminder_app/presentation/setting_screen/controller/setting_controller.dart';

class AddReminderController extends GetxController {
  var tabIndex = 0.obs;
  var category = 'Warranty Card'.obs;
  var reminderType = 'Minute'.obs;
  var currentTime = ''.obs;
  var updatedTime = ''.obs;
  var selectedDateController = TextEditingController().obs();
  var customFromController = TextEditingController().obs();
  var customToController = TextEditingController().obs();
  var customTimeController = TextEditingController().obs();
  var frequencyController = TextEditingController().obs();
  var reminderTitleController = TextEditingController().obs();
  var reminderNoteController = TextEditingController().obs();
  var minuteController = TextEditingController().obs();

  late SettingScreenController controller;

  @override
  void onInit() {
    currentTime.value = DateTime.now().toString();
    selectedDateController.text = '';
    customFromController.text = '';
    customToController.text = '';
    customTimeController.text = '';
    frequencyController.text = '1';
    reminderTitleController.text = '';
    reminderNoteController.text = '';
    minuteController.text = '1';
    super.onInit();
  }

  void setCategory(String value) {
    category.value = value;
  }

  void setReminderType(String value) {
    reminderType.value = value;
  }

  void clearAllValues() {
    reminderTitleController.clear();
    reminderNoteController.clear();
    frequencyController.clear();
    controller.repeatflag.value = true;
    reminderType.refresh();
    controller.taskTime.value = ''.toString();
  }

  renderWidget(val) {
    switch (val) {
      case "Daily":
        return daily_type();
      case "Minute":
        return minute_type();
      case "Hourly":
        return hour_type();
    }

    // else if (reminderType.value == "Minute")
    //   return frequency_input("Minute");
    // else if (reminderType.value == "Hourly")
    //   return frequency_input("Hour");
    // else if (reminderType.value == "Weekly")
    //   return week_type();
    // else if (reminderType.value == "Monthly")
    //   return month_type();
    // else if (reminderType.value == "Yearly")
    //   return year_type();
    // else
    //   return custom_type(ctx);
  }

  @override
  void dispose() {
    currentTime;
    super.dispose();
  }
}
