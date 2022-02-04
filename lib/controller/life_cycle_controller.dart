// ignore_for_file: prefer_const_constructors, prefer_is_empty

import 'dart:async';
import 'dart:ffi';

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

  void callInLoop() async {
    Timer.periodic(Duration(seconds: 1), (timer) async {
      // do something or call a function
      print('every one Second');
      if (taskController.tasks.length > 0) {
        for (var i = 0; i < taskController.tasks.length; i++) {
          print(DateFormat('yyyy-MM-dd hh:mm:ss')
              .parse(taskController.tasks[i].updatedTime.toString()));
          print(DateFormat('yyyy-MM-dd hh:mm:ss')
              .parse(DateTime.now().toString()));

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
            taskobj.customMinute = taskController.tasks[i].customMinute;
            taskobj.reminderType = taskController.tasks[i].reminderType;
            String newpdatedTime = stringToDateTime
                .add(Duration(
                    seconds: int.parse(
                        taskController.tasks[i].customMinute.toString())))
                .toString();
            taskobj.updatedTime = newpdatedTime;
            await taskController.editTask(taskobj);
            print('Diffrence OP:' +
                taskController.tasks[i].customMinute.toString());
            taskController.showNotification(
                int.parse(taskController.tasks[i].taskId.toString()),
                int.parse(taskController.tasks[i].customMinute.toString()),
                taskController.tasks[i].taskTitle.toString(),
                'please check app');
            taskController.fetchTasks();
          } else if ((taskController.tasks[i].reminderType == 'Hourly' &&
                  taskController.tasks[i].customHour != null &&
                  taskController.tasks[i].isRepeat == 1) &&
              (DateFormat('yyyy-MM-dd hh:mm:ss')
                      .parse(taskController.tasks[i].updatedTime.toString()) ==
                  DateFormat('yyyy-MM-dd hh:mm:ss')
                      .parse(DateTime.now().toString()))) {
            TaskModel taskobj = TaskModel();
            print('in Hourly-----------------------');
            taskobj.taskId = taskController.tasks[i].taskId;
            taskobj.time = taskController.tasks[i].time;
            taskobj.taskTitle = taskController.tasks[i].taskTitle;
            taskobj.categoryName = taskController.tasks[i].categoryName;
            taskobj.isActive = 1;
            taskobj.isRepeat = 1;
            taskobj.customHour = taskController.tasks[i].customHour;
            taskobj.reminderType = taskController.tasks[i].reminderType;
            String newpdatedTime = stringToDateTime
                .add(Duration(
                    seconds: int.parse(
                        taskController.tasks[i].customHour.toString())))
                .toString();
            taskobj.updatedTime = newpdatedTime;
            await taskController.editTask(taskobj);

            print('Diffrence:' + taskController.tasks[i].customHour.toString());
            taskController.showNotification(
                int.parse(taskController.tasks[i].taskId.toString()),
                int.parse(taskController.tasks[i].customHour.toString()),
                taskController.tasks[i].taskTitle.toString(),
                'please check app');
            taskController.fetchTasks();
          }
        }
      }
    });
  }
}
