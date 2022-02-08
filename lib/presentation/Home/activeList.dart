// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/model/taskModel.dart';
import 'package:reminder_app/presentation/Remainder/addRemainder.dart';
import 'package:reminder_app/utills/colors.dart';
import 'package:reminder_app/utills/customtext.dart';

import '../../main.dart';

Widget list(int flag) {
  return
      // taskController.tasks.length <= 0
      //     ? Center(
      //         child: Image.asset(
      //         'assets/noData.png',
      //         scale: 4,
      //       ))
      //     :

      Obx(
    () => Align(
      alignment: Alignment.topCenter,
      child: ListView.builder(
          shrinkWrap: true,
          //scrollDirection: Axis.vertical,
          reverse: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: taskController.tasks.length,
          itemBuilder: (BuildContext context, int index) {
            return taskController.tasks[index].isActive == flag
                ? Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side:
                            BorderSide(color: (Colors.grey[350]!), width: 0.7),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      elevation: 0,
                      child: InkWell(
                        onTap: () {
                          Get.defaultDialog(
                            backgroundColor: Colors.transparent,
                            title: "",
                            barrierDismissible: true,
                            content: AlertDialog(
                                insetPadding: EdgeInsets.zero,
                                scrollable: true,
                                content: Column(
                                  children: [
                                    CustomText(
                                      text: taskController
                                          .tasks[index].taskTitle
                                          .toString(),
                                      size: 20,
                                      color: black,
                                    ),
                                    SizedBox(
                                      height: 17,
                                    ),
                                    Text(
                                      taskController.tasks[index].description
                                          .toString(),
                                    ),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text("OK"),
                                  )
                                ]),
                          );
                        },
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
                                      text: taskController
                                          .tasks[index].taskTitle
                                          .toString(),
                                      color: black,
                                      size: 18,
                                    ),
                                    Spacer(),
                                    flag == 1
                                        ? PopupMenuButton(
                                            icon: Icon(Icons.more_vert),
                                            color: white,
                                            itemBuilder: (context) => [
                                              PopupMenuItem<int>(
                                                value: 0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  // ignore: prefer_const_literals_to_create_immutables
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
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
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
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
                                            onSelected: (item) async {
                                              if (item == 0) {
                                                await taskController
                                                    .cancleNotification(
                                                        int.parse(taskController
                                                            .tasks[index].taskId
                                                            .toString()));
                                                TaskModel taskObj = TaskModel();
                                                taskObj =
                                                    taskController.tasks[index];
                                                taskObj.isActive = 0;
                                                taskObj.isRepeat = 0;
                                                // taskObj.taskId =
                                                //     taskController.tasks[index].taskId;
                                                // taskObj.time =
                                                //     taskController.tasks[index].time;
                                                // taskObj.updatedTime = taskController
                                                //     .tasks[index].updatedTime;
                                                await taskController
                                                    .editTask(taskObj);
                                                taskController.fetchTasks();
                                              }
                                              if (item == 1) {
                                                Get.to(() => add_Remainders(),
                                                    arguments: {
                                                      "testArg": taskController
                                                          .tasks[index],
                                                    });
                                              }
                                              if (item == 2) {
                                                await taskController
                                                    .cancleNotification(
                                                        int.parse(taskController
                                                            .tasks[index].taskId
                                                            .toString()));
                                                await taskController.deleteTask(
                                                    int.parse(taskController
                                                        .tasks[index].taskId
                                                        .toString()));
                                                taskController.fetchTasks();
                                              }
                                            },
                                          )
                                        : PopupMenuButton(
                                            icon: Icon(Icons.more_vert),
                                            color: white,
                                            itemBuilder: (context) => [
                                              PopupMenuItem<int>(
                                                value: 0,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
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
                                            onSelected: (item) async {
                                              if (item == 0) {
                                                await taskController
                                                    .cancleNotification(
                                                        int.parse(taskController
                                                            .tasks[index].taskId
                                                            .toString()));
                                                await taskController.deleteTask(
                                                    int.parse(taskController
                                                        .tasks[index].taskId
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
                                      Icons.description_outlined,
                                      color: green,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Text(
                                        taskController.tasks[index].description
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 17,
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
                                      text: taskController
                                          .tasks[index].categoryName
                                          .toString(),
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
                                      text: DateFormat('d MMM, h:mm a')
                                          .format(DateTime.parse(taskController
                                              .tasks[index].time
                                              .toString()))
                                          .toString(),
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
                                      text: DateFormat('h:mm a')
                                          .format(DateTime.parse(taskController
                                              .tasks[index].updatedTime
                                              .toString()))
                                          .toString(),
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
                    ),
                  )
                : Center(child: SizedBox());
          }),
    ),
  );
}
