// ignore_for_file: prefer_const_constructors, unrelated_type_equality_checks, prefer_is_empty

import 'dart:async';

import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/controller/task_controller.dart';
import 'package:reminder_app/model/taskModel.dart';
import 'package:reminder_app/presentation/Home/bottomNav.dart';
import 'package:reminder_app/utills/notification_service.dart';

final taskController = Get.put(TaskController());

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  NotificationService().initNotification();
  runApp(const MyApp());
  var cron = Cron();
  // cron.schedule(Schedule.parse('*/1 * * * *'), () async {

  // });

  Timer.periodic(Duration(seconds: 1), (timer) async {
    // do something or call a function
    print('every one Second');
    if (taskController.tasks.length > 0) {
      for (var i = 0; i < taskController.tasks.length; i++) {
        print(taskController.tasks[i].taskTitle);
        print(DateFormat('yyyy-MM-dd hh:mm:ss')
            .parse(taskController.tasks[i].updatedTime.toString()));
        print(
            DateFormat('yyyy-MM-dd hh:mm:ss').parse(DateTime.now().toString()));

        if (taskController.tasks[i].reminderType == 'Minute' &&
            taskController.tasks[i].customDay != null &&
            taskController.tasks[i].isRepeat == 1) {
          if (DateFormat('yyyy-MM-dd hh:mm:ss')
                  .parse(taskController.tasks[i].updatedTime.toString()) ==
              DateFormat('yyyy-MM-dd hh:mm:ss')
                  .parse(DateTime.now().toString())) {
            var duration = Duration(
                    minutes:
                        int.parse(taskController.tasks[i].customDay.toString()))
                .inSeconds;
            TaskModel taskobj = TaskModel();
            DateTime stringToDateTime = DateFormat("yyyy-MM-dd hh:mm:ss")
                .parse(taskController.tasks[i].updatedTime.toString());
            taskobj.taskId = taskController.tasks[i].taskId;
            taskobj.time = taskController.tasks[i].time;
            taskobj.taskTitle = taskController.tasks[i].taskTitle;
            taskobj.categoryName = taskController.tasks[i].categoryName;
            taskobj.isActive = 1;
            taskobj.isRepeat = 1;
            taskobj.customDay = taskController.tasks[i].customDay;
            taskobj.reminderType = taskController.tasks[i].reminderType;
            String newpdatedTime =
                stringToDateTime.add(Duration(seconds: duration)).toString();
            taskobj.updatedTime = newpdatedTime;
            await taskController.editTask(taskobj);
            final difference = DateFormat('yyyy-MM-dd hh:mm:ss')
                .parse(taskobj.updatedTime.toString())
                .difference(DateTime.now())
                .inSeconds;
            print('Diffrence:' + difference.toString());
            taskController.showNotification(
                int.parse(taskController.tasks[i].taskId.toString()),
                difference,
                taskController.tasks[i].taskTitle.toString(),
                'please check app');
            taskController.fetchTasks();
          }
        }
      }
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
      home: LandingPage(),
    );
  }
}
