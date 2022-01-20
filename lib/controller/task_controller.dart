import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_app/model/taskModel.dart';
import 'package:reminder_app/network/apis.dart';
import 'package:reminder_app/utills/notification_service.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class TaskController extends GetxController {
  var tasks = List<TaskModel>.empty(growable: true).obs;

  @override
  void onInit() {
    tasks.value = [];
    fetchTasks();
    tz.initializeTimeZones();

    super.onInit();
  }

  fetchTasks() async {
    DBProvider.db.getTaskList().then((taskList) => tasks.value = taskList);
  }

  showNotification() {
    NotificationService().showNotification(1, "title", "body", 2);
  }

  cancleNotification() {
    NotificationService().cancelAllNotifications();
  }

  addNewTask(TaskModel taskobj) async {
    print('in insert');
    TaskModel taskObj = new TaskModel();
    //taskObj.taskTitle = 'Light Bill';
    await DBProvider.db.addTask(taskObj);
  }

  deleteTask(int taskId) async {
    await DBProvider.db.deleteTask(taskId);
  }
}
