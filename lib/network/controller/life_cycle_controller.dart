// ignore_for_file: prefer_const_constructors, prefer_is_empty

import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/core/app_export.dart';
import 'package:reminder_app/presentation/home_screen/controller/home_controller.dart';

class LifeCycleController extends GetxController {
  @override
  void onDetached() {
    //  callInLoop();
  }

  @override
  void onInactive() {
    // callInLoop();
  }

  @override
  void onPaused() {
    //callInLoop();
  }

  @override
  void onResumed() {
    //callInLoop();
  }

  void callInLoop() async {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      // do something or call a function
      print('every one Second');
      if (Get.find<HomeScreenController>().tasks.length > 0) {
        for (var i = 0;
            i < Get.find<HomeScreenController>().tasks.length;
            i++) {
          print(DateFormat('yyyy-MM-dd hh:mm:ss').parse(
              Get.find<HomeScreenController>()
                  .tasks[i]
                  .updatedTime
                  .toString()));
          print(DateFormat('yyyy-MM-dd hh:mm:ss')
              .parse(DateTime.now().toString()));

          DateTime stringToDateTime = DateFormat("yyyy-MM-dd hh:mm:ss").parse(
              Get.find<HomeScreenController>().tasks[i].updatedTime.toString());
          if ((Get.find<HomeScreenController>().tasks[i].reminderType ==
                      'Minute' &&
                  Get.find<HomeScreenController>().tasks[i].customMinute !=
                      null &&
                  Get.find<HomeScreenController>().tasks[i].isRepeat == 1) &&
              (DateFormat('yyyy-MM-dd hh:mm:ss').parse(
                      Get.find<HomeScreenController>()
                          .tasks[i]
                          .updatedTime
                          .toString()) ==
                  DateFormat('yyyy-MM-dd hh:mm:ss')
                      .parse(DateTime.now().toString()))) {
            print('in Minute-----------------------');
            TaskModel taskobj = TaskModel();
            taskobj.taskId = Get.find<HomeScreenController>().tasks[i].taskId;
            taskobj.time = Get.find<HomeScreenController>().tasks[i].time;
            taskobj.taskTitle =
                Get.find<HomeScreenController>().tasks[i].taskTitle;
            taskobj.categoryName =
                Get.find<HomeScreenController>().tasks[i].categoryName;
            taskobj.isActive = 1;
            taskobj.isRepeat = 1;
            taskobj.customMinute =
                Get.find<HomeScreenController>().tasks[i].customMinute;
            taskobj.reminderType =
                Get.find<HomeScreenController>().tasks[i].reminderType;
            String newpdatedTime = stringToDateTime
                .add(Duration(
                    seconds: int.parse(Get.find<HomeScreenController>()
                        .tasks[i]
                        .customMinute
                        .toString())))
                .toString();
            taskobj.updatedTime = newpdatedTime;
            await Get.find<HomeScreenController>().editTask(taskobj);
            print('Diffrence OP:' +
                Get.find<HomeScreenController>()
                    .tasks[i]
                    .customMinute
                    .toString());
            Get.find<HomeScreenController>().showNotification(
                int.parse(Get.find<HomeScreenController>()
                    .tasks[i]
                    .taskId
                    .toString()),
                int.parse(Get.find<HomeScreenController>()
                    .tasks[i]
                    .customMinute
                    .toString()),
                Get.find<HomeScreenController>().tasks[i].taskTitle.toString(),
                'From getX LifeCycle');
            Get.find<HomeScreenController>().fetchTasks();
          } else if ((Get.find<HomeScreenController>().tasks[i].reminderType ==
                      'Hourly' &&
                  Get.find<HomeScreenController>().tasks[i].customHour !=
                      null &&
                  Get.find<HomeScreenController>().tasks[i].isRepeat == 1) &&
              (DateFormat('yyyy-MM-dd hh:mm:ss').parse(
                      Get.find<HomeScreenController>()
                          .tasks[i]
                          .updatedTime
                          .toString()) ==
                  DateFormat('yyyy-MM-dd hh:mm:ss')
                      .parse(DateTime.now().toString()))) {
            TaskModel taskobj = TaskModel();
            print('in Hourly-----------------------');
            taskobj.taskId = Get.find<HomeScreenController>().tasks[i].taskId;
            taskobj.time = Get.find<HomeScreenController>().tasks[i].time;
            taskobj.taskTitle =
                Get.find<HomeScreenController>().tasks[i].taskTitle;
            taskobj.categoryName =
                Get.find<HomeScreenController>().tasks[i].categoryName;
            taskobj.isActive = 1;
            taskobj.isRepeat = 1;
            taskobj.customHour =
                Get.find<HomeScreenController>().tasks[i].customHour;
            taskobj.reminderType =
                Get.find<HomeScreenController>().tasks[i].reminderType;
            String newpdatedTime = stringToDateTime
                .add(Duration(
                    seconds: int.parse(Get.find<HomeScreenController>()
                        .tasks[i]
                        .customHour
                        .toString())))
                .toString();
            taskobj.updatedTime = newpdatedTime;
            await Get.find<HomeScreenController>().editTask(taskobj);

            print('Diffrence:' +
                Get.find<HomeScreenController>()
                    .tasks[i]
                    .customHour
                    .toString());
            Get.find<HomeScreenController>().showNotification(
                int.parse(Get.find<HomeScreenController>()
                    .tasks[i]
                    .taskId
                    .toString()),
                int.parse(Get.find<HomeScreenController>()
                    .tasks[i]
                    .customHour
                    .toString()),
                Get.find<HomeScreenController>().tasks[i].taskTitle.toString(),
                'From getX LifeCycle');
            Get.find<HomeScreenController>().fetchTasks();
          } else if ((Get.find<HomeScreenController>().tasks[i].reminderType ==
                      'Weekly' &&
                  Get.find<HomeScreenController>().tasks[i].customWeek !=
                      null &&
                  Get.find<HomeScreenController>().tasks[i].isRepeat == 1) &&
              (DateFormat('yyyy-MM-dd hh:mm:ss').parse(
                      Get.find<HomeScreenController>()
                          .tasks[i]
                          .updatedTime
                          .toString()) ==
                  DateFormat('yyyy-MM-dd hh:mm:ss')
                      .parse(DateTime.now().toString()))) {
            TaskModel taskobj = TaskModel();
            print('in Weekly-----------------------');
            taskobj.taskId = Get.find<HomeScreenController>().tasks[i].taskId;
            taskobj.time = Get.find<HomeScreenController>().tasks[i].time;
            taskobj.taskTitle =
                Get.find<HomeScreenController>().tasks[i].taskTitle;
            taskobj.categoryName =
                Get.find<HomeScreenController>().tasks[i].categoryName;
            taskobj.isActive = 1;
            taskobj.isRepeat = 1;
            taskobj.customWeek =
                Get.find<HomeScreenController>().tasks[i].customWeek;
            taskobj.reminderType =
                Get.find<HomeScreenController>().tasks[i].reminderType;
            String newpdatedTime = stringToDateTime
                .add(Duration(
                    seconds: int.parse(Get.find<HomeScreenController>()
                        .tasks[i]
                        .customWeek
                        .toString())))
                .toString();
            taskobj.updatedTime = newpdatedTime;
            await Get.find<HomeScreenController>().editTask(taskobj);

            print('Diffrence:' +
                Get.find<HomeScreenController>()
                    .tasks[i]
                    .customWeek
                    .toString());
            Get.find<HomeScreenController>().showNotification(
                int.parse(Get.find<HomeScreenController>()
                    .tasks[i]
                    .taskId
                    .toString()),
                int.parse(Get.find<HomeScreenController>()
                    .tasks[i]
                    .customWeek
                    .toString()),
                Get.find<HomeScreenController>().tasks[i].taskTitle.toString(),
                'From getX LifeCycle');
            Get.find<HomeScreenController>().fetchTasks();
          } else if ((Get.find<HomeScreenController>().tasks[i].reminderType ==
                      'Daily' &&
                  Get.find<HomeScreenController>().tasks[i].customDay != null &&
                  Get.find<HomeScreenController>().tasks[i].isRepeat == 1) &&
              (DateFormat('yyyy-MM-dd hh:mm:ss').parse(
                      Get.find<HomeScreenController>()
                          .tasks[i]
                          .updatedTime
                          .toString()) ==
                  DateFormat('yyyy-MM-dd hh:mm:ss')
                      .parse(DateTime.now().toString()))) {
            TaskModel taskobj = TaskModel();
            print('in Daily-----------------------');
            taskobj.taskId = Get.find<HomeScreenController>().tasks[i].taskId;
            taskobj.time = Get.find<HomeScreenController>().tasks[i].time;
            taskobj.taskTitle =
                Get.find<HomeScreenController>().tasks[i].taskTitle;
            taskobj.categoryName =
                Get.find<HomeScreenController>().tasks[i].categoryName;
            taskobj.isActive = 1;
            taskobj.isRepeat = 1;
            taskobj.customDay =
                Get.find<HomeScreenController>().tasks[i].customDay;
            taskobj.reminderType =
                Get.find<HomeScreenController>().tasks[i].reminderType;
            String newpdatedTime = stringToDateTime
                .add(Duration(
                    seconds: int.parse(Get.find<HomeScreenController>()
                        .tasks[i]
                        .customDay
                        .toString())))
                .toString();
            taskobj.updatedTime = newpdatedTime;
            await Get.find<HomeScreenController>().editTask(taskobj);
            print('Diffrence:' +
                Get.find<HomeScreenController>().tasks[i].customDay.toString());
            Get.find<HomeScreenController>().showNotification(
                int.parse(Get.find<HomeScreenController>()
                    .tasks[i]
                    .taskId
                    .toString()),
                int.parse(Get.find<HomeScreenController>()
                    .tasks[i]
                    .customDay
                    .toString()),
                Get.find<HomeScreenController>().tasks[i].taskTitle.toString(),
                'From getX LifeCycle');
            Get.find<HomeScreenController>().fetchTasks();
          }
        }
      }
    });
  }
}
