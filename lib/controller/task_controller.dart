// ignore_for_file: unused_local_variable, unnecessary_new, avoid_print

import 'dart:async';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/model/taskModel.dart';
import 'package:reminder_app/network/apis.dart';
import 'package:reminder_app/network/session.dart';
import 'package:reminder_app/utills/notification_service.dart';
import 'package:timezone/data/latest.dart' as tz;

class TaskController extends GetxController {
  var tasks = List<TaskModel>.empty(growable: true).obs;
  var searchData = List<TaskModel>.empty(growable: true).obs;

  late Timer timer;
  List taskId = [];
  late String catName = ''.obs();
  var searchValue = ''.obs;

  @override
  void onInit() {
    tasks.value = [];
    searchData.value = [];
    fetchTasks();
    tz.initializeTimeZones();
    super.onInit();
  }

  setSearchValue(value) {
    searchValue.value = value;
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
    print('In Edit API');
    await DBProvider.db.updateTask(taskObj);
  }

  setSession(String defaultTime) {
    SharedPrefrences.setSession('default_time', defaultTime);
  }

  fetchSearchTasks({catName}) async {
    print("Fetch search");
    print(catName);
    if (catName == null || catName == "") {
      DBProvider.db.getTaskList().then((value) {
        searchData.value = value;
      });
    } else {
      DBProvider.db.getTaskByCat(catName).then((taskList) {
        searchData.value = taskList;
        print(searchData);
      });
    }
  }
}
