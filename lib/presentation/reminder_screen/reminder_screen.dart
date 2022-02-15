import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/core/app_export.dart';
import 'package:reminder_app/core/utils/color_constant.dart';
import 'package:reminder_app/presentation/home_screen/controller/home_controller.dart';
import 'package:reminder_app/presentation/reminder_screen/controller/reminder_controller.dart';
import 'package:reminder_app/presentation/reminder_screen/widgets/reminder_body.dart';
import 'package:reminder_app/presentation/setting_screen/controller/setting_controller.dart';
import 'package:reminder_app/theme/app_style.dart';

TaskModel taskobj = TaskModel();

class AddReminderScreen extends GetWidget<AddReminderController> {
  const AddReminderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    var data = Get.arguments;
    taskobj = data['testArg'];
    print(taskobj.toJson().toString());
    WidgetsBinding.instance?.addPostFrameCallback((_) => checkStatus());

    return Form(
      key: formKey,
      child: Scaffold(
        backgroundColor: Color(0xffeeeeee),
        appBar: AppBar(
          elevation: 3,
          backgroundColor: ColorConstant.green,
          // ignore: prefer_const_constructors
          title: Text(
            'Add Reminder',
            style: AppStyle.appBarTitle,
          ),
          leading: IconButton(
            // ignore: prefer_const_constructors
            icon: Icon(
              Icons.arrow_back_ios,
              color: ColorConstant.white,
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
                  color: ColorConstant.white,
                ),
                onPressed: () async {
                  print(controller.frequencyController.text);
                  var custom_week;
                  var custom_minute;
                  var custom_hour;
                  DateTime weekIntoSecond;
                  if (formKey.currentState!.validate()) {
                    // print(addTaskController.reminderTitleController.text);
                    // print(addTaskController.category);
                    // print(addTaskController.reminderType);
                    if (controller.frequencyController.text.isNotEmpty) {
                      int seconds = Duration(
                              seconds: int.parse(
                                  controller.frequencyController.text))
                          .inSeconds;
                    }
                    var now = DateTime.now();
                    late DateTime updatedDate;
                    if (controller.reminderType.value == 'Weekly') {
                      custom_week =
                          int.parse(controller.frequencyController.text);
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
                      SharedPrefrences.getSession('default_time').then((value) {
                        print('insesssion');
                        print(value);
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

                        print(updatedDate);
                        print(weekIntoSecond);
                        print('-------++--------------');
                        weekIntoSecond = updatedDate.difference(now).inSeconds;
                        print(weekIntoSecond);
                        taskobj.customWeek = weekIntoSecond;
                      });
                    }

                    if (controller.reminderType.value == 'Minute') {
                      custom_minute =
                          int.parse(controller.frequencyController.text);
                      int minuteIntoSecond =
                          Duration(minutes: custom_minute).inSeconds;
                      print(now);
                      print('----------------Minute-----------------');
                      updatedDate =
                          now.add(Duration(seconds: minuteIntoSecond));
                      print(updatedDate);
                      taskobj.customMinute = minuteIntoSecond;
                    }

                    if (controller.reminderType.value == 'Hourly') {
                      custom_hour =
                          int.parse(controller.frequencyController.text);
                      int hourIntoSecond =
                          Duration(hours: custom_hour).inSeconds;
                      print(hourIntoSecond);
                      print(now);
                      print('----------------Hourly-----------------');
                      updatedDate = now.add(Duration(seconds: hourIntoSecond));
                      print(updatedDate);
                      taskobj.customHour = hourIntoSecond;
                    }

                    if (controller.reminderType.value == 'Daily') {
                      print(now);
                      print('----------------Daily-----------------');
                      updatedDate = now.add(Duration(seconds: 86400));
                      // var finaldefaultTime = DateFormat.jm()
                      //     .parse(settingController.defaultTime.toString());
                      // var newHour = finaldefaultTime.hour;
                      // var newMinute = finaldefaultTime.minute;
                      // ignore: unnecessary_new
                      updatedDate = new DateTime(
                          updatedDate.year,
                          updatedDate.month,
                          updatedDate.day,
                          // newHour,
                          // newMinute,
                          00,
                          updatedDate.millisecond,
                          updatedDate.microsecond);

                      print(updatedDate);
                      int dailyIntoSecond;
                      dailyIntoSecond = updatedDate.difference(now).inSeconds;
                      print(dailyIntoSecond);
                      taskobj.customDay = dailyIntoSecond;
                      // taskobj.selectedDays =
                      // settingController.defaultTime.toString();
                    }
                    taskobj.taskTitle = controller.reminderTitleController.text;
                    taskobj.categoryName = controller.category.toString();
                    taskobj.time = now.toString();
                    taskobj.updatedTime =
                        updatedDate == null ? '' : updatedDate.toString();
                    taskobj.isActive = 1;
                    taskobj.description =
                        controller.reminderNoteController.text;
                    // taskobj.isRepeat =
                    //     settingController.repeatflag == true ? 1 : 0;
                    // taskobj.isSnoozed =
                    //     settingController.snoozeflag == true ? 1 : 0;
                    taskobj.reminderType = controller.reminderType.toString();
                    if (taskobj.taskId == null) {
                      Get.find<HomeScreenController>().addNewTask(taskobj);
                    } else {
                      Get.find<HomeScreenController>().editTask(taskobj);
                    }
                    var lastInsertedId = await Get.find<HomeScreenController>()
                        .getLastInsertedId();
                    if (updatedDate != null || updatedDate != "") {
                      final difference = updatedDate.difference(now).inSeconds;
                      Get.find<HomeScreenController>().showNotification(
                          lastInsertedId[0]['task_id'],
                          difference,
                          controller.reminderTitleController.text,
                          'Reminder');
                      print(
                          '-------ALARM WILL PLAYS ON--------------------------' +
                              updatedDate.toString() +
                              '----------AFTER SECONDS:-----------' +
                              difference.toString());
                    }
                    Get.find<HomeScreenController>().fetchTasks();
                    Get.back();
                  }
                },
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(child: Reminderbody()),
      ),
    );
  }
}

checkStatus() {
  if (taskobj.taskId != null) {
    Get.find<AddReminderController>().reminderTitleController.text =
        taskobj.taskTitle.toString();
    Get.find<AddReminderController>().category.value =
        taskobj.categoryName.toString();
    Get.find<AddReminderController>().reminderType.value =
        taskobj.reminderType.toString();
    Get.find<AddReminderController>().reminderNoteController.text =
        taskobj.description.toString();
    Get.find<SettingScreenController>().repeatflag.value =
        taskobj.isRepeat == 1 ? true : false;
    Get.find<SettingScreenController>().snoozeflag.value =
        taskobj.isSnoozed == 1 ? true : false;
    if (taskobj.reminderType.toString() == 'Minute') {
      var seconds = int.parse(taskobj.customMinute.toString());
      Get.find<AddReminderController>().frequencyController.text =
          Duration(seconds: seconds).inMinutes.toString();
    }
    if (taskobj.reminderType.toString() == 'Hourly') {
      var seconds = int.parse(taskobj.customHour.toString());
      Get.find<AddReminderController>().frequencyController.text =
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
      Get.find<AddReminderController>().frequencyController.text =
          totalWeeks.toString();
    }
    if (taskobj.reminderType.toString() == 'Daily') {
      Get.find<SettingScreenController>().taskTime.value =
          taskobj.selectedDays.toString();
    }
  }
}
