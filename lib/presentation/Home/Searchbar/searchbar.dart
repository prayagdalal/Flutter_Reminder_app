// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/controller/task_controller.dart';
import 'package:reminder_app/model/taskModel.dart';
import 'package:reminder_app/presentation/Remainder/addRemainder.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: Center(
          child: CustomText(
            text: 'Search',
            color: white,
            size: 18,
            weight: FontWeight.w800,
          ),
        ),
        actions: [custome_popupmenu()],
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: white,
            )),
      ),
      body: list_display(),
      // body: custome_popupmenu(),
    );
  }
}

Widget custome_popupmenu() {
  final taskController = Get.put(TaskController());
  return PopupMenuButton(
    icon: Icon(
      Icons.category,
      color: white,
    ),
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
      // await taskController
      //     .searchTask(int.parse(taskController.tasks[index].taskId.toString()));
      print('--------------in');
      // var data = await taskController.searchTask(item.toString());
      //print(data);
      //displayData(data);
      await taskController.fetchSearchTasks(item.toString());
      print(taskController.searchData);
      //taskController.fetchTasks();
    },
  );
}

/*Widget custome_body() {
  return Padding(
    padding: const EdgeInsets.only(top: 15, left: 8, right: 8),
    child: Column(
      children: [
        SizedBox(
          height: 100,
          child: TextFormField(
            textInputAction: TextInputAction.done,
            //decoration: getTextBorder(),
          ),
        )
      ],
    ),
  );
}*/

/*InputDecoration getTextBorder() {
  return InputDecoration(
    suffixIcon: Icon(
      Icons.search,
      color: green,
    ),
    filled: true,
    hintText: "Search here..",
    fillColor: Colors.grey[50],
    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: green, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: green, width: 1),
    ),
  );
}*/
Widget list_display() {
  print("List Display");
  final taskController = Get.put(TaskController());
  return
      // taskController.tasks.length <= 0
      //     ? Center(
      //         child: Image.asset(
      //         'assets/noData.png',
      //         scale: 4,
      //       ))
      //     :

      Obx(
    () => ListView.builder(
        physics: NeverScrollableScrollPhysics(), // <-- this will disable scroll
        shrinkWrap: true,
        itemCount: taskController.searchData.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Card(
              shape: RoundedRectangleBorder(
                side: BorderSide(color: (Colors.grey[350]!), width: 0.7),
                borderRadius: BorderRadius.circular(6.0),
              ),
              elevation: 0,
              child: InkWell(
                onTap: () {
                  Get.to(() => add_Remainders(), arguments: {
                    "testArg": taskController.searchData[index],
                  });
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
                              text: taskController.searchData[index].taskTitle
                                  .toString(),
                              color: black,
                              size: 18,
                            ),
                            Spacer(),
                            // PopupMenuButton(
                            //   icon: Icon(Icons.more_vert),
                            //   color: white,
                            //   itemBuilder: (context) => category
                            //       .map((item) => PopupMenuItem<String>(
                            //             value: item,
                            //             child: CustomText(
                            //               text: item,
                            //               size: 16,
                            //               weight: FontWeight.w600,
                            //             ),
                            //           ))
                            //       .toList(),
                            //   onSelected: (item) async {
                            //     await taskController.searchTask(
                            //         taskController.tasks[index].categoryName);

                            //     // if (item == 0) {
                            //     //   await taskController.cancleNotification(
                            //     //       int.parse(taskController
                            //     //           .tasks[index].taskId
                            //     //           .toString()));
                            //     //   TaskModel taskObj = TaskModel();
                            //     //   taskObj = taskController.tasks[index];
                            //     //   taskObj.isActive = 0;
                            //     //   // taskObj.taskId =
                            //     //   //     taskController.tasks[index].taskId;
                            //     //   // taskObj.time =
                            //     //   //     taskController.tasks[index].time;
                            //     //   // taskObj.updatedTime = taskController
                            //     //   //     .tasks[index].updatedTime;
                            //     //   await taskController.editTask(taskObj);
                            //     //   taskController.fetchTasks();
                            //     // }
                            //     // if (item == 2) {
                            //     //   await taskController.cancleNotification(
                            //     //       int.parse(taskController
                            //     //           .tasks[index].taskId
                            //     //           .toString()));
                            //     //   await taskController.deleteTask(
                            //     //       int.parse(taskController
                            //     //           .tasks[index].taskId
                            //     //           .toString()));
                            //     //   taskController.fetchTasks();
                            //     // }
                            //   },
                            // ),
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
                              text: taskController
                                  .searchData[index].categoryName
                                  .toString(),
                              color: Colors.black,
                              size: 13,
                            ),
                            Spacer(),
                            // Icon(
                            //   Icons.calendar_today,
                            //   color: green,
                            // ),
                            SizedBox(
                              width: 5,
                            ),
                            // CustomText(
                            //   text: DateFormat('E, dd MMM, h:mm a')
                            //       .format(DateTime.parse(taskController
                            //           .tasks[index].time
                            //           .toString()))
                            //       .toString(),
                            //   color: Colors.black,
                            //   size: 13,
                            // ),
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
            ),
          );
        }),
  );
}
