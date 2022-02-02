// ignore_for_file: prefer_const_constructors, avoid_print, curly_braces_in_flow_control_structures, unused_local_variable, prefer_typing_uninitialized_variables, non_constant_identifier_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/controller/task_controller.dart';
import 'package:reminder_app/model/taskModel.dart';
import 'package:reminder_app/network/session.dart';
import 'package:reminder_app/presentation/Remainder/remainderBody.dart';
import 'package:reminder_app/utills/colors.dart';
import 'package:reminder_app/utills/customtext.dart';

class add_Remainders extends StatelessWidget {
  const add_Remainders({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    addTaskController.reminderTitleController.clear();
    addTaskController.reminderNoteController.clear();
    final taskController = Get.put(TaskController());
    final formKey = GlobalKey<FormState>();
    var data = Get.arguments;
    TaskModel taskobj = TaskModel();
    taskobj = data['testArg'];
    print(taskobj.toJson().toString());

    if (taskobj.taskId != null) {
      addTaskController.reminderTitleController.text =
          taskobj.taskTitle.toString();
      addTaskController.category.value = taskobj.categoryName.toString();
    }
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
                  print(addTaskController.frequencyController.text);
                  var custom_week;
                  var custom_minute;
                  var custom_hour;
                  DateTime weekIntoSecond;
                  if (formKey.currentState!.validate()) {
                    // print(addTaskController.reminderTitleController.text);
                    // print(addTaskController.category);
                    // print(addTaskController.reminderType);
                    int seconds = Duration(
                            seconds: int.parse(
                                addTaskController.frequencyController.text))
                        .inSeconds;
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
                      print(weekIntoSecond);
                      print(now);
                      print('-------------Weekly--------------------');
                      updatedDate = now.add(Duration(seconds: weekIntoSecond));
                      print(updatedDate);
                      String defaultTime = '';
                      TimeOfDay defaultTimeFinal =
                          TimeOfDay(hour: 15, minute: 0);
                      SharedPrefrences.getSession('default_time').then((value) {
                        print('insesssion');
                        defaultTime = value;
                        defaultTimeFinal =
                            settingController.stringToTimeOfDay(defaultTime);
                      });
                      var newHour = defaultTimeFinal.hour;
                      var newMinute = defaultTimeFinal.minute;
                      updatedDate = updatedDate.toLocal();
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
                      print(updatedDate);
                    }

                    if (addTaskController.reminderType.value == 'Minute') {
                      custom_minute =
                          int.parse(addTaskController.frequencyController.text);
                      int minuteIntoSecond =
                          Duration(minutes: custom_minute).inSeconds;
                      print(now);
                      print('----------------Minute-----------------');
                      updatedDate =
                          now.add(Duration(seconds: minuteIntoSecond));
                      print(updatedDate);
                      taskobj.customMinute = minuteIntoSecond;
                    }

                    if (addTaskController.reminderType.value == 'Hourly') {
                      custom_hour =
                          int.parse(addTaskController.frequencyController.text);
                      int hourIntoSecond =
                          Duration(hours: custom_hour).inSeconds;
                      print(hourIntoSecond);
                      print(now);
                      print('----------------Hourly-----------------');
                      updatedDate = now.add(Duration(seconds: hourIntoSecond));
                      print(updatedDate);
                      taskobj.customHour = hourIntoSecond;
                    }

                    taskobj.taskTitle =
                        addTaskController.reminderTitleController.text;
                    taskobj.categoryName =
                        addTaskController.category.toString();
                    taskobj.time = now.toString();
                    taskobj.updatedTime = updatedDate.toString();
                    taskobj.isActive = 1;
                    taskobj.isRepeat = 1;
                    taskobj.reminderType =
                        addTaskController.reminderType.toString();

                    if (taskobj.taskId == null) {
                      taskController.addNewTask(taskobj);
                    } else {
                      taskController.editTask(taskobj);
                    }

                    var lastInsertedId =
                        await taskController.getLastInsertedId();
                    final difference = updatedDate.difference(now).inSeconds;
                    taskController.showNotification(
                        lastInsertedId[0]['task_id'],
                        difference,
                        addTaskController.reminderTitleController.text,
                        'Reminder');
                    print(
                        '-------ALARM WILL PLAYS ON--------------------------' +
                            updatedDate.toString() +
                            '----------AFTER SECONDS:-----------' +
                            difference.toString());

                    taskController.fetchTasks();
                    addTaskController.reminderTitleController.clear();
                    addTaskController.reminderNoteController.clear();
                    Get.back();
                  }
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(child: remainder_body(context)),
      ),
    );
  }
}
