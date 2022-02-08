// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks, prefer_is_empty, avoid_print, prefer_const_declarations

import 'dart:async';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_foreground_plugin/flutter_foreground_plugin.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:splash_screen_view/SplashScreenView.dart';

import 'package:reminder_app/controller/task_controller.dart';
import 'package:reminder_app/model/taskModel.dart';
import 'package:reminder_app/network/session.dart';
import 'package:reminder_app/presentation/Home/bottomNav.dart';
import 'package:reminder_app/utills/colors.dart';
import 'package:reminder_app/utills/notification_service.dart';
import 'controller/add_taskController.dart';
import 'controller/life_cycle_controller.dart';
import 'controller/setting_controller.dart';

final taskController = Get.put(TaskController());
final addTaskController = Get.put(AddTaskController());
final settingController = Get.put(SettingController());
final lifeCycleController = Get.put(LifeCycleController());

void callInLoop() async {
  // Timer.periodic(Duration(seconds: 1), (timer) async {
  // do something or call a function
  print('every one Second From Forground Service');
  if (taskController.tasks.length > 0) {
    for (var i = 0; i < taskController.tasks.length; i++) {
      print(DateFormat('yyyy-MM-dd hh:mm:ss')
          .parse(taskController.tasks[i].updatedTime.toString()));
      print(DateFormat('yyyy-MM-dd hh:mm:ss').parse(DateTime.now().toString()));

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
                seconds:
                    int.parse(taskController.tasks[i].customMinute.toString())))
            .toString();
        taskobj.updatedTime = newpdatedTime;
        await taskController.editTask(taskobj);
        print(
            'Diffrence OP:' + taskController.tasks[i].customMinute.toString());
        taskController.showNotification(
            int.parse(taskController.tasks[i].taskId.toString()),
            int.parse(taskController.tasks[i].customMinute.toString()),
            taskController.tasks[i].taskTitle.toString(),
            'From foreground!');
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
        taskobj.description = taskController.tasks[i].description;

        taskobj.customHour = taskController.tasks[i].customHour;
        taskobj.reminderType = taskController.tasks[i].reminderType;
        String newpdatedTime = stringToDateTime
            .add(Duration(
                seconds:
                    int.parse(taskController.tasks[i].customHour.toString())))
            .toString();
        taskobj.updatedTime = newpdatedTime;
        await taskController.editTask(taskobj);

        print('Diffrence:' + taskController.tasks[i].customHour.toString());
        taskController.showNotification(
            int.parse(taskController.tasks[i].taskId.toString()),
            int.parse(taskController.tasks[i].customHour.toString()),
            taskController.tasks[i].taskTitle.toString(),
            'From foreground!');
        taskController.fetchTasks();
      } else if ((taskController.tasks[i].reminderType == 'Weekly' &&
              taskController.tasks[i].customWeek != null &&
              taskController.tasks[i].isRepeat == 1) &&
          (DateFormat('yyyy-MM-dd hh:mm:ss')
                  .parse(taskController.tasks[i].updatedTime.toString()) ==
              DateFormat('yyyy-MM-dd hh:mm:ss')
                  .parse(DateTime.now().toString()))) {
        TaskModel taskobj = TaskModel();
        print('in Weekly-----------------------');
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
                seconds:
                    int.parse(taskController.tasks[i].customWeek.toString())))
            .toString();
        taskobj.updatedTime = newpdatedTime;
        await taskController.editTask(taskobj);

        print('Diffrence:' + taskController.tasks[i].customWeek.toString());
        taskController.showNotification(
            int.parse(taskController.tasks[i].taskId.toString()),
            int.parse(taskController.tasks[i].customWeek.toString()),
            taskController.tasks[i].taskTitle.toString(),
            'From foreground!');
        taskController.fetchTasks();
      } else if ((taskController.tasks[i].reminderType == 'Daily' &&
              taskController.tasks[i].customDay != null &&
              taskController.tasks[i].isRepeat == 1) &&
          (DateFormat('yyyy-MM-dd hh:mm:ss')
                  .parse(taskController.tasks[i].updatedTime.toString()) ==
              DateFormat('yyyy-MM-dd hh:mm:ss')
                  .parse(DateTime.now().toString()))) {
        TaskModel taskobj = TaskModel();
        print('in Daily-----------------------');
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
                seconds:
                    int.parse(taskController.tasks[i].customDay.toString())))
            .toString();
        taskobj.updatedTime = newpdatedTime;
        await taskController.editTask(taskobj);
        print('Diffrence:' + taskController.tasks[i].customDay.toString());
        taskController.showNotification(
            int.parse(taskController.tasks[i].taskId.toString()),
            int.parse(taskController.tasks[i].customDay.toString()),
            taskController.tasks[i].taskTitle.toString(),
            'From foreground!');
        taskController.fetchTasks();
      }
    }
  }
  // });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  //await AndroidAlarmManager.initialize();

  Get.put(LifeCycleController());
  //await AndroidAlarmManager.initialize();
  runApp(const MyApp());
  //final int helloAlarmID = 0;
  // await AndroidAlarmManager.periodic(
  //   const Duration(seconds: 1),
  //   helloAlarmID,
  //   callInLoop,
  // );

  startForegroundService();

  SharedPrefrences.getSession('default_time').then((value) {
    if (value.isEmpty || value == '') {
      taskController.setSession('10:00 PM');
    }
  });
}

Map<int, Color> color = {
  50: Color.fromRGBO(30, 59, 112, .1),
  100: Color.fromRGBO(30, 59, 112, .2),
  200: Color.fromRGBO(30, 59, 112, .3),
  300: Color.fromRGBO(30, 59, 112, .4),
  400: Color.fromRGBO(30, 59, 112, .5),
  500: Color.fromRGBO(30, 59, 112, .6),
  600: Color.fromRGBO(30, 59, 112, .7),
  700: Color.fromRGBO(30, 59, 112, .8),
  800: Color.fromRGBO(30, 59, 112, .9),
  900: Color.fromRGBO(30, 59, 112, 1),
};
MaterialColor colorCustom = MaterialColor(0xff02953F, color);

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: colorCustom,
      ),
      home: SplashScreenView(
        navigateRoute: LandingPage(),
        duration: 2000,
        speed: 50,
        imageSize: 130,
        imageSrc: "assets/splash.png",
        text: "Reminder",
        textType: TextType.NormalText,
        textStyle: TextStyle(
          fontSize: 25.0,
          letterSpacing: 1.0,
          color: green,
        ),
        backgroundColor: white,
      ),
    );
  }
}

void startForegroundService() async {
  await FlutterForegroundPlugin.setServiceMethodInterval(seconds: 1);
  await FlutterForegroundPlugin.setServiceMethod(globalForegroundService);
  await FlutterForegroundPlugin.startForegroundService(
    holdWakeLock: false,
    onStarted: () {
      print("Foreground on Started");
    },
    onStopped: () {
      print("Foreground on Stopped");
    },
    title: 'APPNAME',
    content: "Timer is runnint",
    iconName: '',
  );
}

void globalForegroundService() {
  callInLoop();
}
