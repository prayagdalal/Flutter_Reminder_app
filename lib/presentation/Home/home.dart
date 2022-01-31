// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:reminder_app/model/taskModel.dart';
import 'package:reminder_app/network/apis.dart';
import 'package:reminder_app/presentation/Home/Searchbar/searchbar.dart';
import 'package:get/get.dart';
import 'package:reminder_app/controller/task_controller.dart';
import 'package:reminder_app/presentation/Home/tabbar.dart';
import 'package:reminder_app/presentation/Remainder/addRemainder.dart';
import 'package:reminder_app/utills/colors.dart';
import 'package:reminder_app/utills/customtext.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskController = Get.put(TaskController());

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
              // taskController.showNotification();
              Get.to(() => SearchBarPage());
              //taskController.backupfilecreation();
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
