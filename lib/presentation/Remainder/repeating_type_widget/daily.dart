// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:reminder_app/model/taskModel.dart';
import 'package:reminder_app/utills/colors.dart';
import 'package:reminder_app/utills/customtext.dart';
import '../../../main.dart';

Widget daily_type(BuildContext context, TaskModel taskobj) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              selectTime(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Card(
                color: green,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      CustomText(
                        text: 'Your Reminder Will Pop-up on ',
                        color: white,
                        size: 14,
                      ),
                      CustomText(
                        text: taskobj.selectedDays == null
                            ? settingController.defaultTime.toString()
                            : settingController.taskTIme.toString(),
                        color: white,
                        weight: FontWeight.bold,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // ListTile(
          //     onTap: () {
          //       selectTime(context);
          //       // showTimePicker(context: ctx, initialTime: TimeOfDay.now());
          //     },
          //     leading: Icon(Icons.av_timer),
          //     title: CustomText(
          //       text: "Set Default Time",
          //       weight: FontWeight.w500,
          //     ),
          //     dense: true,
          //     trailing: Obx(() => CustomText(
          //           text: settingController.defaultTime.toString(),
          //           color: green,
          //         ))),
          // CustomText(
          //   text: "Every",
          // ),
          // Container(
          //   width: 130,
          //   child: TextFormField(
          //     maxLength: 2,
          //     decoration: InputDecoration(
          //       enabledBorder: UnderlineInputBorder(
          //         borderSide: BorderSide(color: green),
          //       ),
          //     ),
          //   ),
          // ),
          // CustomText(
          //   text: "Day",
          // ),
        ],
      )
    ],
  );
}

TimeOfDay selectetime = TimeOfDay.now();
selectTime(BuildContext ctx) async {
  final TimeOfDay? picked = await showTimePicker(
      context: ctx,
      initialTime: settingController
          .stringToTimeOfDay(settingController.defaultTime.value));

  if (picked != null && picked != selectetime) {
    DateTime tempDate = DateFormat("hh:mm")
        .parse(picked.hour.toString() + ":" + picked.minute.toString());
    var dateFormat = DateFormat("h:mm a");
    settingController.defaultTime.value = dateFormat.format(tempDate);
    // print(settingController.defaultTime.value);
    var taskController2 = taskController;
    taskController2.setSession(dateFormat.format(tempDate));
  }

}
