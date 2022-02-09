// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/controller/task_controller.dart';
import 'package:reminder_app/utills/colors.dart';
import 'package:reminder_app/utills/customtext.dart';

var category = [
  "Warrnty Card",
  "Coupon",
  "PUC",
  "Property Rent",
  "Premium",
  "Bill Payment",
  "Credit Card",
  "Recharge",
  "EMI",
  "Loan",
];

class SearchBarPage extends StatelessWidget {
  SearchBarPage({Key? key}) : super(key: key);
  final taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    taskController.fetchSearchTasks();
    return Obx(() => Scaffold(
          appBar: AppBar(
            backgroundColor: green,
            title: taskController.searchValue.value.isEmpty
                ? Text("Search")
                : Text(taskController.searchValue.value.toString()),
            actions: [
              PopupMenuButton(
                  icon: Icon(Icons.category, color: white),
                  color: white,
                  itemBuilder: (context) => category
                      .map((item) => PopupMenuItem<String>(
                            value: item,
                            child: CustomText(
                              text: item,
                              size: 16,
                              weight: FontWeight.w600,
                            ),
                          ))
                      .toList(),
                  onSelected: (item) async {
                    taskController.setSearchValue(item.toString());
                    await taskController.fetchSearchTasks(
                        catName: item.toString());
                  })
            ],
            leading: IconButton(
                onPressed: () {
                  taskController.searchValue.value = 'All';
                  Get.back();
                },
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: white,
                )),
          ),
          body: Container(
            child: list_display(),
          ),
        ));
  }
}

Widget list_display() {
  final taskController = Get.put(TaskController());
  return taskController.searchData.length <= 0
      ? //taskController.fetchTasks()
      Center(
          child: Image.asset(
          'assets/noData.png',
          scale: 4,
        ))
      : Obx(
          () => Align(
            alignment: Alignment.topCenter,
            child: ListView.builder(
                shrinkWrap: true,
                reverse: true,
                itemCount: taskController.searchData.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      if (taskController.searchData[index].description !=
                          null) {
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
                                    text: taskController
                                        .searchData[index].taskTitle
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
                      padding:
                          const EdgeInsets.only(left: 10, right: 10, top: 12),
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
                                    text: taskController
                                        .searchData[index].taskTitle
                                        .toString(),
                                    color: black,
                                    size: 19,
                                    weight: FontWeight.w600,
                                  ),
                                  Spacer(),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              taskController.searchData[index].description == ""
                                  ? Text("")
                                  : Visibility(
                                      visible: (taskController.searchData[index]
                                                      .description ==
                                                  null ||
                                              taskController.searchData[index]
                                                      .description ==
                                                  "")
                                          ? false
                                          : true,
                                      child: Text(
                                        taskController
                                            .searchData[index].description
                                            .toString(),
                                        overflow: TextOverflow.ellipsis,
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
                  );
                }),
          ),
        );
}
