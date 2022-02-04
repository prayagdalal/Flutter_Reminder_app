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
  final taskController = Get.put(TaskController());
  // int length;
  // length= taskController.tasks.length;

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
              //custome_popupmenu()
              //final taskController = Get.put(TaskController());
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
                    // await taskController
                    //     .searchTask(int.parse(taskController.tasks[index].taskId.toString()));
                    print('--------------in');
                    // var data = await taskController.searchTask(item.toString());
                    //print(data);
                    //displayData(data);
                    taskController.setSearchValue(item.toString());
                    //print(itemName);
                    await taskController.fetchSearchTasks(
                        catName: item.toString());
                    print(taskController.searchData.value);
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
          // list_display(),

          // body: custome_popupmenu(),
        ));
  }
}

// Widget custome_popupmenu() {
//   final taskController = Get.put(TaskController());
//   return PopupMenuButton(
//     icon: Icon(
//       Icons.category,
//       color: white,
//     ),
//     color: white,
//     itemBuilder: (context) => category
//         .map((item) => PopupMenuItem<String>(
//               value: item,
//               child: CustomText(
//                 text: item,
//                 size: 16,
//                 weight: FontWeight.w600,
//               ),
//             ))
//         .toList(),
//     onSelected: (item) async {
//       // await taskController
//       //     .searchTask(int.parse(taskController.tasks[index].taskId.toString()));
//       print('--------------in');
//       // var data = await taskController.searchTask(item.toString());
//       //print(data);
//       //displayData(data);
//       await taskController.fetchSearchTasks(item.toString());
//       print(taskController.searchData);
//       //taskController.fetchTasks();
//     },
//   );
// }

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
  return taskController.searchData.length <= 0
      ? //taskController.fetchTasks()
      Center(
          child: Image.asset(
          'assets/noData.png',
          scale: 4,
        ))
      : Obx(
          () => ListView.builder(
              physics:
                  NeverScrollableScrollPhysics(), // <-- this will disable scroll
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
                                    text: taskController
                                        .searchData[index].taskTitle
                                        .toString(),
                                    color: black,
                                    size: 18,
                                  ),
                                  Spacer(),
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
