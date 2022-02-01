// ignore_for_file: prefer_const_constructors, avoid_print, unnecessary_new, duplicate_ignore, unused_import

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/model/taskModel.dart';
import 'package:reminder_app/network/apis.dart';
import 'package:reminder_app/network/session.dart';
import 'package:reminder_app/presentation/Home/Searchbar/searchbar.dart';
import 'package:get/get.dart';
import 'package:reminder_app/controller/task_controller.dart';
import 'package:reminder_app/presentation/Home/tabbar.dart';
import 'package:reminder_app/presentation/Remainder/addRemainder.dart';
import 'package:reminder_app/utills/colors.dart';
import 'package:reminder_app/utills/customtext.dart';

import '../../main.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String date = DateFormat.jm().format(DateTime.now());
    print(date);
    SharedPrefrences.getSession('default_time').then((value) {
      if (value.isEmpty || value == '') {
        taskController.setSession('10:00 PM');
      }
    });
    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      appBar: AppBar(
        elevation: 3,
        backgroundColor: green,
        // ignore: prefer_const_constructors
        title: CustomText(
          text: 'Reminder App',
          color: white,
          size: 18,
          weight: FontWeight.w800,
        ),
        actions: [
          IconButton(
            // ignore: prefer_const_constructors
            constraints: BoxConstraints.tight(Size.fromWidth(30)),

            icon: Icon(
              Icons.search_rounded,
              color: white,
            ),
            onPressed: () {
              //  DBProvider.db.deleteTbl();
              //Get.to(() => SearchBarPage());
              // var dayOfWeek = 5;
              // DateTime date = DateTime.now();
              // var lastMonday = date
              //     .subtract(Duration(days: 21 + dayOfWeek))
              //     .toIso8601String();
              // print(dayOfWeek);
              // print('----------------------------');
              // print(lastMonday);
              var newHour = 5;
              var time = DateTime.now();
              print(time);
              time = new DateTime(time.year, time.month, time.day, newHour,
                  time.minute, time.second, time.millisecond, time.microsecond);

              print(time);
              Get.to(() => SearchBarPage());
            },
          ),
          SizedBox(
            width: 20,
          ),
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: IconButton(
              padding: EdgeInsets.all(0),

              // ignore: prefer_const_constructors
              icon: Icon(
                Icons.add_rounded,
                color: white,
              ),
              onPressed: () {
                // taskController.addNewTask();
                // taskController.fetchTasks();
                // Get.to(add_Remainders());
                TaskModel addTaskObj = TaskModel();
                Get.to(() => add_Remainders(), arguments: {
                  "testArg": addTaskObj,
                });
              },
            ),
          ),
        ],
      ),
      body: tabBar(),
    );
  }
}
