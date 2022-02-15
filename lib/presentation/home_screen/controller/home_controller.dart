import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_app/core/app_export.dart';
import 'package:reminder_app/data/apiClient/api_client.dart';
import 'package:reminder_app/network/notification_service.dart';
import 'package:reminder_app/presentation/home_screen/widgets/home_body.dart';
import 'package:reminder_app/presentation/setting_screen/setting_screen.dart';

class HomeScreenController extends GetxController {
  var tabIndex = 0.obs;
  var tasks = List<TaskModel>.empty(growable: true).obs;
  var searchData = List<TaskModel>.empty(growable: true).obs;
  var searchValue = ''.obs;

  Widget changeTabIndex() {
    switch (tabIndex.value) {
      case 0:
        return HomeBody();

      case 1:
        return SettingScreen();
    }
    return HomeBody();
  }

  @override
  void onInit() {
    tasks.value = [];
    fetchTasks();
    tabIndex.value = 0;
    super.onInit();
  }

  fetchTasks() {
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

  setSearchValue(value) {
    searchValue.value = value;
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

  @override
  void dispose() {
    super.dispose();
  }
}
