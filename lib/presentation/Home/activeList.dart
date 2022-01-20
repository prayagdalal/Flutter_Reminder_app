// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_app/controller/task_controller.dart';
import 'package:reminder_app/network/apis.dart';
import 'package:reminder_app/utills/colors.dart';
import 'package:reminder_app/utills/customtext.dart';

Widget ActiveList() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: CustomText(
          text: 'Today',
          color: black,
          weight: FontWeight.bold,
        ),
      ),
      list(),
      SizedBox(height: 30),
      Padding(
        padding: const EdgeInsets.only(left: 15),
        child: CustomText(
          text: 'Next 7 days',
          color: black,
          weight: FontWeight.bold,
        ),
      ),
      //list(),
    ],
  );
}

Widget list() {
  final taskController = Get.put(TaskController());

  return Obx(
    () => ListView.builder(
        physics: NeverScrollableScrollPhysics(), // <-- this will disable scroll
        shrinkWrap: true,
        itemCount: taskController.tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Card(
              shape: RoundedRectangleBorder(
                side: new BorderSide(color: (Colors.grey[350]!), width: 0.7),
                borderRadius: BorderRadius.circular(6.0),
              ),
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 12, right: 12, top: 12, bottom: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IntrinsicHeight(
                      child: Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          CustomText(
                            text: taskController.tasks[index].taskTitle
                                .toString(),
                            color: black,
                            size: 18,
                          ),
                          IconButton(
                            icon: Icon(Icons.repeat),
                            onPressed: () {},
                          ),
                          Spacer(),
                          PopupMenuButton(
                            icon: Icon(Icons.more_vert),
                            color: white,
                            itemBuilder: (context) => [
                              PopupMenuItem<int>(
                                value: 0,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(Icons.check),
                                    SizedBox(width: 5),
                                    CustomText(
                                      text: "Mark as Done",
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem<int>(
                                value: 1,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Icon(Icons.edit),
                                    SizedBox(width: 5),
                                    CustomText(
                                      text: "Edit",
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem<int>(
                                value: 2,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  // ignore: prefer_const_literals_to_create_immutables
                                  children: [
                                    Icon(Icons.delete),
                                    SizedBox(width: 5),
                                    CustomText(
                                      text: "Delete",
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            onSelected: (item) {
                              if (item == 2) {
                                taskController.deleteTask(int.parse(
                                    taskController.tasks[index].taskId
                                        .toString()));
                                taskController.fetchTasks();
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    IntrinsicHeight(
                      child: Row(
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Icon(
                            Icons.category,
                            color: green,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          CustomText(
                            text: 'Bill Payment',
                            color: Colors.black,
                            size: 13,
                          ),
                          Spacer(),
                          Icon(
                            Icons.calendar_today,
                            color: green,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          CustomText(
                            text: '17-01-2022',
                            color: Colors.black,
                            size: 13,
                          ),
                          Spacer(),
                          Icon(
                            Icons.watch_later_sharp,
                            color: green,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          CustomText(
                            text: '05:25 PM',
                            color: Colors.black,
                            size: 13,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
  );
}
