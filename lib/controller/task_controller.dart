import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/model/taskModel.dart';
import 'package:reminder_app/network/apis.dart';
import 'package:reminder_app/presentation/Home/activeList.dart';
import 'package:reminder_app/utills/notification_service.dart';
import 'package:timezone/data/latest.dart' as tz;

class TaskController extends GetxController {
  var tasks = List<TaskModel>.empty(growable: true).obs;
  late Timer timer;
  List taskId = [];

  @override
  void onInit() {
    tasks.value = [];
    fetchTasks();
    tz.initializeTimeZones();
    //  timer = Timer.periodic(Duration(seconds: 1), (Timer t) => fetchTasks());
    fetchTasks();

    super.onInit();
  }

  fetchTasks() async {
    DateTime currentDate = new DateFormat("yyyy-MM-dd HH:mm:ss.SSS")
        .parse(DateTime.now().toString());
    DBProvider.db.getTaskList().then((taskList) {
      tasks.value = taskList;
    });
  }

  getLastInsertedId() async {
    // print(DBProvider.db.getLastInsertedRowId());
    return await DBProvider.db.getLastInsertedRowId();
  }

  showNotification(int taskId, int seconds, String title, String body) async {
    await NotificationService().showNotification(taskId, title, body, seconds);
  }

  repeatNotification() async {
    await NotificationService().repeatNotification();
  }

  cancleNotification(int taskId) async {
    await NotificationService().cancelNotification(taskId);
  }

  addNewTask(TaskModel taskobj) async {
    print('in insert');
    print(taskobj);
    await DBProvider.db.addTask(taskobj);
  }

  deleteTask(int taskId) async {
    await DBProvider.db.deleteTask(taskId);
  }

  editTask(TaskModel taskObj) async {
    await DBProvider.db.updateTask(taskObj);
  }
}
