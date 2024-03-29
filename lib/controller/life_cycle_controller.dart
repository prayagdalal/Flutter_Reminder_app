// ignore_for_file: prefer_const_constructors, prefer_is_empty

import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/model/taskModel.dart';

import '../main.dart';

class LifeCycleController extends SuperController {
  @override
  void onDetached() {
    callInLoop();
  }

  @override
  void onInactive() {
    callInLoop();
  }

  @override
  void onPaused() {
    callInLoop();
  }

  @override
  void onResumed() {
    callInLoop();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    callInLoop();
  }

  void callInLoop() async {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      //do something or call a function
      // print('every one Second From Getx');
      if (taskController.tasks.length > 0) {
        for (var i = 0; i < taskController.tasks.length; i++) {
          // print(DateFormat('yyyy-MM-dd hh:mm:ss')
          //     .parse(taskController.tasks[i].updatedTime.toString()));
          // print(DateFormat('yyyy-MM-dd hh:mm:ss')
          //     .parse(DateTime.now().toString()));

          DateTime stringToDateTime = DateFormat("yyyy-MM-dd hh:mm:ss")
              .parse(taskController.tasks[i].updatedTime.toString());
          if ((taskController.tasks[i].reminderType == 'Minute' &&
                  taskController.tasks[i].customMinute != null &&
                  taskController.tasks[i].isRepeat == 1) &&
              (DateFormat('yyyy-MM-dd hh:mm:ss')
                      .parse(taskController.tasks[i].updatedTime.toString()) ==
                  DateFormat('yyyy-MM-dd hh:mm:ss')
                      .parse(DateTime.now().toString()))) {
            print('in Minute-----------------------');
            TaskModel taskobj = TaskModel();
            taskobj.taskId = taskController.tasks[i].taskId;
            taskobj.time = taskController.tasks[i].time;
            taskobj.taskTitle = taskController.tasks[i].taskTitle;
            taskobj.categoryName = taskController.tasks[i].categoryName;
            taskobj.isActive = 1;
            taskobj.isRepeat = 1;
            taskobj.description = taskController.tasks[i].description;

            taskobj.customMinute = taskController.tasks[i].customMinute;
            taskobj.reminderType = taskController.tasks[i].reminderType;
            String newpdatedTime = stringToDateTime
                .add(Duration(
                    seconds: int.parse(
                        taskController.tasks[i].customMinute.toString())))
                .toString();
            taskobj.updatedTime = newpdatedTime;
            await taskController.editTask(taskobj);
            // print('Diffrence OP:' +
            //     taskController.tasks[i].customMinute.toString());
            taskController.showNotification(
                int.parse(taskController.tasks[i].taskId.toString()),
                int.parse(taskController.tasks[i].customMinute.toString()),
                taskController.tasks[i].taskTitle.toString(),
                'From getX!');
            taskController.fetchTasks();
          } else if ((taskController.tasks[i].reminderType == 'Hourly' &&
                  taskController.tasks[i].customHour != null &&
                  taskController.tasks[i].isRepeat == 1) &&
              (DateFormat('yyyy-MM-dd hh:mm:ss')
                      .parse(taskController.tasks[i].updatedTime.toString()) ==
                  DateFormat('yyyy-MM-dd hh:mm:ss')
                      .parse(DateTime.now().toString()))) {
            TaskModel taskobj = TaskModel();
            // print('in Hourly-----------------------');
            taskobj.taskId = taskController.tasks[i].taskId;
            taskobj.time = taskController.tasks[i].time;
            taskobj.taskTitle = taskController.tasks[i].taskTitle;
            taskobj.categoryName = taskController.tasks[i].categoryName;
            taskobj.isActive = 1;
            taskobj.isRepeat = 1;
            taskobj.description = taskController.tasks[i].description;

            taskobj.customHour = taskController.tasks[i].customHour;
            taskobj.reminderType = taskController.tasks[i].reminderType;
            String newpdatedTime = stringToDateTime
                .add(Duration(
                    seconds: int.parse(
                        taskController.tasks[i].customHour.toString())))
                .toString();
            taskobj.updatedTime = newpdatedTime;
            await taskController.editTask(taskobj);

            // print('Diffrence:' + taskController.tasks[i].customHour.toString());
            taskController.showNotification(
                int.parse(taskController.tasks[i].taskId.toString()),
                int.parse(taskController.tasks[i].customHour.toString()),
                taskController.tasks[i].taskTitle.toString(),
                'From getX!');
            taskController.fetchTasks();
          } else if ((taskController.tasks[i].reminderType == 'Weekly' &&
                  taskController.tasks[i].customWeek != null &&
                  taskController.tasks[i].isRepeat == 1) &&
              (DateFormat('yyyy-MM-dd hh:mm:ss')
                      .parse(taskController.tasks[i].updatedTime.toString()) ==
                  DateFormat('yyyy-MM-dd hh:mm:ss')
                      .parse(DateTime.now().toString()))) {
            TaskModel taskobj = TaskModel();
            // print('in Weekly-----------------------');
            taskobj.taskId = taskController.tasks[i].taskId;
            taskobj.time = taskController.tasks[i].time;
            taskobj.taskTitle = taskController.tasks[i].taskTitle;
            taskobj.categoryName = taskController.tasks[i].categoryName;
            taskobj.isActive = 1;
            taskobj.isRepeat = 1;
            taskobj.description = taskController.tasks[i].description;

            taskobj.customWeek = taskController.tasks[i].customWeek;
            taskobj.reminderType = taskController.tasks[i].reminderType;
            String newpdatedTime = stringToDateTime
                .add(Duration(
                    seconds: int.parse(
                        taskController.tasks[i].customWeek.toString())))
                .toString();
            taskobj.updatedTime = newpdatedTime;
            await taskController.editTask(taskobj);

            // print('Diffrence:' + taskController.tasks[i].customWeek.toString());
            taskController.showNotification(
                int.parse(taskController.tasks[i].taskId.toString()),
                int.parse(taskController.tasks[i].customWeek.toString()),
                taskController.tasks[i].taskTitle.toString(),
                'From getX!');
            taskController.fetchTasks();
          } else if ((taskController.tasks[i].reminderType == 'Daily' &&
                  taskController.tasks[i].customDay != null &&
                  taskController.tasks[i].isRepeat == 1) &&
              (DateFormat('yyyy-MM-dd hh:mm:ss')
                      .parse(taskController.tasks[i].updatedTime.toString()) ==
                  DateFormat('yyyy-MM-dd hh:mm:ss')
                      .parse(DateTime.now().toString()))) {
            TaskModel taskobj = TaskModel();
            //print('in Daily-----------------------');
            taskobj.taskId = taskController.tasks[i].taskId;
            taskobj.time = taskController.tasks[i].time;
            taskobj.taskTitle = taskController.tasks[i].taskTitle;
            taskobj.categoryName = taskController.tasks[i].categoryName;
            taskobj.isActive = 1;
            taskobj.isRepeat = 1;
            taskobj.description = taskController.tasks[i].description;
            taskobj.customDay = taskController.tasks[i].customDay;
            taskobj.reminderType = taskController.tasks[i].reminderType;
            String newpdatedTime = stringToDateTime
                .add(Duration(
                    seconds: int.parse(
                        taskController.tasks[i].customDay.toString())))
                .toString();
            taskobj.updatedTime = newpdatedTime;
            await taskController.editTask(taskobj);
            // print('Diffrence:' + taskController.tasks[i].customDay.toString());
            taskController.showNotification(
                int.parse(taskController.tasks[i].taskId.toString()),
                int.parse(taskController.tasks[i].customDay.toString()),
                taskController.tasks[i].taskTitle.toString(),
                'From getX!');
            taskController.fetchTasks();
          }
        }
      }
    });
  }
}
