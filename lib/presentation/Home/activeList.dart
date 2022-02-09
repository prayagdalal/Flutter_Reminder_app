import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../model/taskModel.dart';
import '../Remainder/addRemainder.dart';
import '../../utills/colors.dart';
import '../../utills/customtext.dart';

import '../../main.dart';

Widget list(int flag) {
  return Obx(
    () => Align(
      alignment: Alignment.topCenter,
      child: ListView.builder(
          shrinkWrap: true,
          reverse: true,
          itemCount: taskController.tasks.length,
          itemBuilder: (BuildContext context, int index) {
            return taskController.tasks[index].isActive == flag
                ? GestureDetector(
                    onTap: () {
                      if (taskController.tasks[index].description != null &&
                          taskController.tasks[index].description != "") {
                        Get.defaultDialog(
                          backgroundColor: Colors.transparent,
                          barrierDismissible: true,
                          title: "",
                          content: AlertDialog(
                              insetPadding: EdgeInsets.zero,
                              elevation: 0,
                              scrollable: true,
                              content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: taskController.tasks[index].taskTitle
                                        .toString(),
                                    size: 18,
                                    color: black,
                                    weight: FontWeight.w600,
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  CustomText(
                                    text: taskController
                                        .tasks[index].description
                                        .toString(),
                                    size: 14,
                                  ),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  child: Text("OK"),
                                ),
                              ]),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: (Colors.grey[350]!), width: 0.7),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        elevation: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 12, right: 12, top: 12, bottom: 12),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  CustomText(
                                    text: taskController.tasks[index].taskTitle
                                        .toString(),
                                    color: black,
                                    size: 19,
                                    weight: FontWeight.w600,
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
                                                  .cancleNotification(int.parse(
                                                      taskController
                                                          .tasks[index].taskId
                                                          .toString()));
                                              TaskModel taskObj = TaskModel();
                                              taskObj =
                                                  taskController.tasks[index];
                                              taskObj.isActive = 0;
                                              taskObj.isRepeat = 0;

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
                                                  .cancleNotification(int.parse(
                                                      taskController
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
                                                  .cancleNotification(int.parse(
                                                      taskController
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
                              Visibility(
                                visible:
                                    (taskController.tasks[index].description ==
                                                null ||
                                            taskController
                                                    .tasks[index].description ==
                                                "")
                                        ? false
                                        : true,
                                child: Text(
                                  taskController.tasks[index].description
                                      .toString(),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 13),
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Divider(),
                              IntrinsicHeight(
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.category,
                                      color: green,
                                      size: 18,
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
                                      size: 18,
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
                                      size: 18,
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
