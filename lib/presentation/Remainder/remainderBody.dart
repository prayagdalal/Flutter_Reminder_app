// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/controller/add_taskController.dart';
import 'package:reminder_app/controller/setting_controller.dart';
import 'package:reminder_app/presentation/Remainder/repeating_type_widget/custom.dart';
import 'package:reminder_app/presentation/Remainder/repeating_type_widget/every_widget.dart';
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
var settingController = Get.put(SettingController());

Widget remainder_body(ctx) {
  // AddTaskController addTaskController = AddTaskController();
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
                              text: "Select Category",
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
                      height: 15,
                    ),
                    CustomText(
                      text: 'Reminder Title',
                      weight: FontWeight.w500,
                      color: black,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      textInputAction: TextInputAction.done,
                      controller: addTaskController.reminderTitleController,
                      decoration: getTextBorder(),
                      // The validator receives the text that the user has entered.
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please Enter Reminder Title';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CustomText(
                          text: 'Alarm at: ' + formattedDate,
                          size: 16,
                          weight: FontWeight.w700,
                          color: black,
                        ),
                      ],
                    ),
                    SizedBox(height: 13),
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
                    Obx(() => _renderWidget(ctx)),
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
                      controller: addTaskController.reminderNoteController,
                      decoration: getTextBorder(),
                      maxLines: 5,
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ListTile(
                        onTap: null,
                        contentPadding: EdgeInsets.zero,
                        //leading: Icon(Icons.snooze_outlined),
                        title: CustomText(
                          text: "Snooze",
                          weight: FontWeight.w500,
                        ),
                        dense: true,
                        trailing: Obx(() => Switch(
                            value: settingController.snoozeflag.value,
                            onChanged: (val) {
                              settingController.snoozechange();
                              print(settingController.snoozeflag);
                            }))),
                    Visibility(
                      visible: true,
                      child: Column(
                        children: [
                          // addRadioButton(0, '1 Minutes', '1 Minutes'),
                          // addRadioButton(1, '5 Minutes', '5 Minutes'),
                        ],
                      ),
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

Widget _renderWidget(ctx) {
  if (addTaskController.reminderType.value == "Daiiiply")
    return frequency_input("Day");
  else if (addTaskController.reminderType.value == "Minute")
    return frequency_input("Minute");
  else if (addTaskController.reminderType.value == "Hourly")
    return frequency_input("Hour");
  else if (addTaskController.reminderType.value == "Weekly")
    return week_type();
  else if (addTaskController.reminderType.value == "Monthly")
    return month_type(ctx);
  else if (addTaskController.reminderType.value == "Yearly")
    return year_type(ctx);
  else
    return custom_type(ctx);
}
// "Minute",
// "Hourly",
// "Daily",
// "Weekly",
// "Monthly",
// "Yearly",
// "Custom"

addRadioButton(int btnIndex, String title, String interval) {
  return Container(
    child: Row(
      children: [
        GetBuilder<AddTaskController>(
          builder: (_) => Radio(
              activeColor: green,
              value: addTaskController.gender[btnIndex],
              groupValue: addTaskController.select,
              onChanged: (value) {
                addTaskController.onClickRadioButton(value);
              }),
        ),
        CustomText(text: interval)
      ],
    ),
  );
}
