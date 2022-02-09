// ignore_for_file: prefer_const_constructors, avoid_print, curly_braces_in_flow_control_structures, unused_local_variable, prefer_typing_uninitialized_variables, non_constant_identifier_names, camel_case_types, unrelated_type_equality_checks, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/model/taskModel.dart';
import 'package:reminder_app/network/session.dart';
import 'package:reminder_app/presentation/Remainder/remainderBody.dart';
import 'package:reminder_app/utills/colors.dart';
import 'package:reminder_app/utills/customtext.dart';

import '../../main.dart';

TaskModel taskobj = TaskModel();

class add_Remainders extends StatelessWidget {
  const add_Remainders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    var data = Get.arguments;
    taskobj = data['testArg'];
    WidgetsBinding.instance?.addPostFrameCallback((_) => checkStatus());

    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Color(0xffeeeeee),
        appBar: AppBar(
          elevation: 3,
          backgroundColor: green,
          // ignore: prefer_const_constructors
          title: CustomText(
            text: 'Add Reminder',
            color: white,
            size: 18,
            weight: FontWeight.w800,
          ),
          leading: IconButton(
            // ignore: prefer_const_constructors
            icon: Icon(
              Icons.arrow_back_ios,
              color: white,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: IconButton(
                // ignore: prefer_const_constructors
                constraints: BoxConstraints.tight(Size.fromWidth(30)),
                padding: EdgeInsets.all(0),
                // ignore: prefer_const_constructors
                icon: Icon(
                  Icons.check_circle_rounded,
                  color: white,
                ),
                onPressed: () async {
                  var custom_week;
                  var custom_minute;
                  var custom_hour;
                  DateTime weekIntoSecond;
                  if (formKey.currentState!.validate()) {
                    if (addTaskController.frequencyController.text.isNotEmpty) {
                      int seconds = Duration(
                              seconds: int.parse(
                                  addTaskController.frequencyController.text))
                          .inSeconds;
                    }
                    var now = DateTime.now();
                    late DateTime updatedDate;
                    if (addTaskController.reminderType.value == 'Weekly') {
                      custom_week =
                          int.parse(addTaskController.frequencyController.text);
                      if (custom_week == 1)
                        custom_week = 7;
                      else if (custom_week == 2)
                        custom_week = 14;
                      else if (custom_week == 3)
                        custom_week = 21;
                      else if (custom_week == 4) custom_week = 28;
                      int weekIntoSecond =
                          Duration(days: custom_week).inSeconds;

                      updatedDate = now.add(Duration(seconds: weekIntoSecond));
                      SharedPrefrences.getSession('default_time').then((value) {
                        var finaldefaultTime = DateFormat.jm().parse(value);
                        var newHour = finaldefaultTime.hour;
                        var newMinute = finaldefaultTime.minute;
                        // ignore: unnecessary_new
                        updatedDate = new DateTime(
                            updatedDate.year,
                            updatedDate.month,
                            updatedDate.day,
                            newHour,
                            newMinute,
                            00,
                            updatedDate.millisecond,
                            updatedDate.microsecond);

                        weekIntoSecond = updatedDate.difference(now).inSeconds;
                        taskobj.customWeek = weekIntoSecond;
                      });
                    }

                    if (addTaskController.reminderType.value == 'Minute') {
                      custom_minute =
                          int.parse(addTaskController.frequencyController.text);
                      int minuteIntoSecond =
                          Duration(minutes: custom_minute).inSeconds;

                      updatedDate =
                          now.add(Duration(seconds: minuteIntoSecond));
                      taskobj.customMinute = minuteIntoSecond;
                    }

                    if (addTaskController.reminderType.value == 'Hourly') {
                      custom_hour =
                          int.parse(addTaskController.frequencyController.text);
                      int hourIntoSecond =
                          Duration(hours: custom_hour).inSeconds;

                      updatedDate = now.add(Duration(seconds: hourIntoSecond));
                      taskobj.customHour = hourIntoSecond;
                    }

                    if (addTaskController.reminderType.value == 'Daily') {
                      updatedDate = now.add(Duration(seconds: 86400));
                      var finaldefaultTime = DateFormat.jm()
                          .parse(settingController.defaultTime.toString());
                      var newHour = finaldefaultTime.hour;
                      var newMinute = finaldefaultTime.minute;
                      // ignore: unnecessary_new
                      updatedDate = new DateTime(
                          updatedDate.year,
                          updatedDate.month,
                          updatedDate.day,
                          newHour,
                          newMinute,
                          00,
                          updatedDate.millisecond,
                          updatedDate.microsecond);

                      int dailyIntoSecond;
                      dailyIntoSecond = updatedDate.difference(now).inSeconds;

                      taskobj.customDay = dailyIntoSecond;
                      taskobj.selectedDays =
                          settingController.defaultTime.toString();
                    }
                    taskobj.taskTitle =
                        addTaskController.reminderTitleController.text;
                    taskobj.categoryName =
                        addTaskController.category.toString();
                    taskobj.time = now.toString();
                    taskobj.updatedTime =
                        updatedDate == null ? '' : updatedDate.toString();
                    taskobj.isActive = 1;
                    taskobj.description =
                        addTaskController.reminderNoteController.text;
                    taskobj.isRepeat =
                        settingController.repeatflag == true ? 1 : 0;
                    taskobj.isSnoozed =
                        settingController.snoozeflag == true ? 1 : 0;
                    taskobj.reminderType =
                        addTaskController.reminderType.toString();
                    if (taskobj.taskId == null) {
                      taskController.addNewTask(taskobj);
                    } else {
                      taskController.editTask(taskobj);
                    }
                    var lastInsertedId =
                        await taskController.getLastInsertedId();
                    if (updatedDate != null || updatedDate != "") {
                      final difference = updatedDate.difference(now).inSeconds;
                      taskController.showNotification(
                          lastInsertedId[0]['task_id'],
                          difference,
                          addTaskController.reminderTitleController.text,
                          'Reminder');
                    }
                    taskController.fetchTasks();
                    Get.back();
                  }
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(child: remainder_body(context, taskobj)),
      ),
    );
  }
}

checkStatus() {
  if (taskobj.taskId != null) {
    addTaskController.reminderTitleController.text =
        taskobj.taskTitle.toString();
    addTaskController.category.value = taskobj.categoryName.toString();
    addTaskController.reminderType.value = taskobj.reminderType.toString();
    addTaskController.reminderNoteController.text =
        taskobj.description == null ? "" : taskobj.description.toString();
    settingController.repeatflag.value = taskobj.isRepeat == 1 ? true : false;
    settingController.snoozeflag.value = taskobj.isSnoozed == 1 ? true : false;
    if (taskobj.reminderType.toString() == 'Minute') {
      var seconds = int.parse(taskobj.customMinute.toString());
      addTaskController.frequencyController.text =
          Duration(seconds: seconds).inMinutes.toString();
    }
    if (taskobj.reminderType.toString() == 'Hourly') {
      var seconds = int.parse(taskobj.customHour.toString());
      addTaskController.frequencyController.text =
          Duration(seconds: seconds).inHours.toString();
    }
    if (taskobj.reminderType.toString() == 'Weekly') {
      var seconds = int.parse(taskobj.customWeek.toString());
      int totalDays = Duration(seconds: seconds).inDays;
      int totalWeeks = 0;
      if (totalDays >= 7 && totalDays < 14)
        totalWeeks = 1;
      else if (totalDays >= 14 && totalDays < 21)
        totalWeeks = 2;
      else if (totalDays >= 21 && totalDays < 28)
        totalWeeks = 3;
      else if (totalDays >= 28) totalWeeks = 4;
      addTaskController.frequencyController.text = totalWeeks.toString();
    }
    if (taskobj.reminderType.toString() == 'Daily') {
      settingController.taskTIme.value = taskobj.selectedDays.toString();
    }
  }
}
