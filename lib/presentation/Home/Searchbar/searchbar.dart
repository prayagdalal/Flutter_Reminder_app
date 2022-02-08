// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_app/controller/task_controller.dart';
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
                                  SizedBox(
                                    width: 5,
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
                  ),
                );
              }),
        );
}
