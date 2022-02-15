import 'package:flutter/material.dart';
import 'package:googleapis/androidenterprise/v1.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/core/app_export.dart';
import 'package:reminder_app/core/utils/color_constant.dart';
import 'package:reminder_app/presentation/home_screen/controller/home_controller.dart';
import 'package:reminder_app/presentation/reminder_screen/reminder_screen.dart';
import 'package:reminder_app/theme/app_decoration.dart';
import 'package:reminder_app/theme/app_style.dart';

class ActiveList extends GetWidget<HomeScreenController> {
  const ActiveList({Key? key, required this.flag}) : super(key: key);

  final flag;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Align(
        alignment: Alignment.topCenter,
        child: ListView.builder(
            shrinkWrap: true,
            reverse: true,
            itemCount: controller.tasks.length,
            itemBuilder: (BuildContext context, int index) {
              return controller.tasks[index].isActive == flag
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: (Colors.grey[350]!), width: 0.7),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        elevation: 0,
                        child: InkWell(
                          onTap: () {
                            // Get.to(() => AddReminderScreen(), arguments: {
                            //   "testArg": controller.tasks[index],
                            // });
                            if (controller.tasks[index].description != "") {
                              Get.defaultDialog(
                                backgroundColor: Colors.transparent,
                                title: "",
                                barrierDismissible: true,
                                content: AlertDialog(
                                    insetPadding: EdgeInsets.zero,
                                    scrollable: true,
                                    content: Column(
                                      children: [
                                        Text(
                                          controller.tasks[index].taskTitle
                                              .toString(),
                                          style: AppStyle.cardTitleTextStyle,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          controller.tasks[index].description
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
                            }
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
                                      Text(
                                        controller.tasks[index].taskTitle
                                            .toString(),
                                        style: AppStyle.cardTitleTextStyle,
                                      ),
                                      Spacer(),
                                      PopupMenuButton(
                                        icon: Icon(Icons.more_vert),
                                        color: ColorConstant.white,
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
                                                Text("Mark as Done")
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
                                                Text("Edit")
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
                                                Text(
                                                  "Delete",
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                        onSelected: (item) async {
                                          if (item == 0) {
                                            await controller.cancleNotification(
                                                int.parse(controller
                                                    .tasks[index].taskId
                                                    .toString()));
                                            TaskModel taskObj = TaskModel();
                                            taskObj = controller.tasks[index];
                                            taskObj.isActive = 0;
                                            taskObj.isRepeat = 0;

                                            await controller.editTask(taskObj);
                                            controller.fetchTasks();
                                          }
                                          if (item == 2) {
                                            await controller.cancleNotification(
                                                int.parse(controller
                                                    .tasks[index].taskId
                                                    .toString()));
                                            await controller.deleteTask(
                                                int.parse(controller
                                                    .tasks[index].taskId
                                                    .toString()));
                                            controller.fetchTasks();
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                controller.tasks[index].description == ""
                                    ? Text("")
                                    : IntrinsicHeight(
                                        child: Row(
                                          // ignore: prefer_const_literals_to_create_immutables
                                          children: [
                                            Icon(
                                              Icons.description_outlined,
                                              color: ColorConstant.green,
                                            ),
                                            SizedBox(
                                              width: 5,
                                            ),
                                            Expanded(
                                              child: Text(
                                                controller
                                                    .tasks[index].description
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                IntrinsicHeight(
                                  child: Row(
                                    // ignore: prefer_const_literals_to_create_immutables
                                    children: [
                                      Icon(
                                        Icons.category,
                                        color: ColorConstant.green,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        controller.tasks[index].categoryName
                                            .toString(),
                                        style: AppStyle.cardEventTextStyle,
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.calendar_today,
                                        color: ColorConstant.green,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        DateFormat('d MMM, h:mm a')
                                            .format(DateTime.parse(controller
                                                .tasks[index].time
                                                .toString()))
                                            .toString(),
                                        style: AppStyle.cardEventTextStyle,
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.watch_later_sharp,
                                        color: ColorConstant.green,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        DateFormat('h:mm a')
                                            .format(DateTime.parse(controller
                                                .tasks[index].updatedTime
                                                .toString()))
                                            .toString(),
                                        style: AppStyle.cardEventTextStyle,
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
}
