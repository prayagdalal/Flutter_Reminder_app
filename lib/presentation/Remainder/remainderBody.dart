// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:reminder_app/controller/add_taskController.dart';
import 'package:reminder_app/controller/task_controller.dart';
import 'package:reminder_app/presentation/Remainder/repeating_type_widget/custom.dart';
import 'package:reminder_app/presentation/Remainder/repeating_type_widget/daily.dart';
import 'package:reminder_app/presentation/Remainder/repeating_type_widget/hourly.dart';
import 'package:reminder_app/presentation/Remainder/repeating_type_widget/minute.dart';
import 'package:reminder_app/presentation/Remainder/repeating_type_widget/month.dart';
import 'package:reminder_app/presentation/Remainder/repeating_type_widget/week.dart';
import 'package:reminder_app/presentation/Remainder/repeating_type_widget/year.dart';
import 'package:reminder_app/utills/colors.dart';
import 'package:reminder_app/utills/customtext.dart';

List<dynamic> category = [
  {"name": "Warrnty Card", "isSelected": false},
  {"name": "Coupon", "isSelected": false},
  {"name": "PUC", "isSelected": false},
  {"name": "Property Rent", "isSelected": false},
  {"name": "Premium", "isSelected": false},
  {"name": "Bill Payment", "isSelected": false},
  {"name": "Credit Card", "isSelected": false},
  {"name": "Recharge", "isSelected": false},
  {"name": "EMI", "isSelected": false},
  {"name": "Loan", "isSelected": false}
];

var category1 = [
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

var remindertype1 = [
  "Minute",
  "Hourly",
  "Daily",
  "Weekly",
  "Monthly",
  "Yearly",
  "Custom"
];
List<dynamic> remindertype = [
  {"name": "Minute", "isSelected": false},
  {"name": "Hourly", "isSelected": false},
  {"name": "Daily", "isSelected": false},
  {"name": "Weekly", "isSelected": false},
  {"name": "Monthly", "isSelected": false},
  {"name": "Yearly", "isSelected": false},
  {"name": "Custom", "isSelected": false},
];
var addTaskController = Get.put(AddTaskController());

Widget remainder_body(ctx) {
  // AddTaskController addTaskController = AddTaskController();
  print(addTaskController.reminderType.value);
  var parsedDate = DateTime.parse(addTaskController.currentTime.value);
  String formattedDate = DateFormat('EE, dd MMM, h:mm a').format(parsedDate);
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 15,
            ),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Category",
                      weight: FontWeight.w500,
                      color: black,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      decoration: getBorder(),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: DropdownButtonHideUnderline(
                            child: Obx(
                          () => DropdownButton(
                            hint: CustomText(
                              text: " Select Category",
                              color: grey,
                            ),
                            isExpanded: true,
                            onChanged: (newvalue) {
                              addTaskController
                                  .setCategory(newvalue.toString());
                            },
                            value: addTaskController.category.value,
                            items: category1
                                .map((String e) => DropdownMenuItem(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          e,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      value: e,
                                    ))
                                .toList(),
                          ),
                        )),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    CustomText(
                      text: 'Task Title',
                      weight: FontWeight.w500,
                      color: black,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      // controller: _titleController,

                      decoration: getTextBorder(),

                      // The validator receives the text that the user has entered.
                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     return 'Please enter some text';
                      //   }
                      //   return null;
                      // },
                    ),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomText(
                          text: 'Alarm at: ' + formattedDate,
                          size: 16,
                          weight: FontWeight.w800,
                          color: green,
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    CustomText(
                      text: "Repeat type",
                      weight: FontWeight.w500,
                      color: black,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Container(
                      decoration: getBorder(),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: DropdownButtonHideUnderline(
                            child: Obx(
                          () => DropdownButton(
                            hint: CustomText(
                              text: " Select Reminder Type",
                              color: grey,
                            ),
                            isExpanded: true,
                            onChanged: (newvalue) {
                              addTaskController
                                  .setReminderType(newvalue.toString());
                            },
                            value: addTaskController.reminderType.value,
                            items: remindertype1
                                .map((String e) => DropdownMenuItem(
                                      child: Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          e,
                                          style: TextStyle(fontSize: 16),
                                        ),
                                      ),
                                      value: e,
                                    ))
                                .toList(),
                          ),
                        )),
                      ),
                    ),
                    Obx(() => _renderWidget()),
                    SizedBox(
                      height: 8,
                    ),
                    CustomText(
                      text: 'Notes',
                      weight: FontWeight.w500,
                      color: black,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      // controller: _titleController,

                      decoration: getTextBorder(),
                      maxLines: 5,

                      // The validator receives the text that the user has entered.
                      // validator: (value) {
                      //   if (value.isEmpty) {
                      //     return 'Please enter some text';
                      //   }
                      //   return null;
                      // },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );
}

BoxDecoration getBorder() {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(8.0),
    border: Border.all(color: green, style: BorderStyle.solid, width: 0.5),
  );
}

InputDecoration getTextBorder() {
  return InputDecoration(
    filled: true,
    fillColor: Colors.grey[50],
    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(color: green, width: 0.5),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(color: green, width: 0.5),
    ),
  );
}

Widget _renderWidget() {
  if (addTaskController.reminderType.value == "Daily")
    return daily_type();
  else if (addTaskController.reminderType.value == "Minute")
    return minute_type();
  else if (addTaskController.reminderType.value == "Hourly")
    return hour_type();
  else if (addTaskController.reminderType.value == "Weekly")
    return week_type();
  else if (addTaskController.reminderType.value == "Monthly")
    return month_type(context);
  else if (addTaskController.reminderType.value == "Yearly")
    return year_type(context);
  else
    return custom_type(context);
}
  // "Minute",
  // "Hourly",
  // "Daily",
  // "Weekly",
  // "Monthly",
  // "Yearly",
  // "Custom"