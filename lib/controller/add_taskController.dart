import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../main.dart';

class AddTaskController extends GetxController {
  var tabIndex = 0.obs;
  var category = 'Warrnty Card'.obs;
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

  late String selectedGender;
  final List<String> gender = ["Male", "Female"];

  String? select = ''.obs();
  void onClickRadioButton(value) {
    print(value);
    select = value;
    update();
  }

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
    addTaskController.reminderTitleController.clear();
    addTaskController.reminderNoteController.clear();
    addTaskController.frequencyController.clear();
    settingController.repeatflag.value = true;
    settingController.snoozeflag.value = false;
    addTaskController.reminderType.refresh();
    settingController.taskTIme.value = ''.toString();
  }


  @override
  void dispose() {
    currentTime;
    super.dispose();
  }
}
