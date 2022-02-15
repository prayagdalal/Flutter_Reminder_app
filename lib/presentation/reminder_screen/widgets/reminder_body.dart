import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/core/app_export.dart';
import 'package:reminder_app/core/utils/color_constant.dart';
import 'package:reminder_app/presentation/reminder_screen/controller/reminder_controller.dart';
import 'package:reminder_app/presentation/reminder_screen/reminder_screen.dart';
import 'package:reminder_app/theme/app_decoration.dart';
import 'package:reminder_app/theme/app_style.dart';

var parsedDate =
    DateTime.parse(Get.find<AddReminderController>().currentTime.value);
String formattedDate = DateFormat('EE, dd MMM, h:mm a').format(parsedDate);

List<dynamic> category = [
  {"name": "Warranty Card", "isSelected": false},
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
  "Warranty Card",
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
  // "Monthly",
  // "Yearly",
  // "Custom"
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

class Reminderbody extends GetWidget<AddReminderController> {
  const Reminderbody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                      Text(
                        "Category",
                        style: AppStyle.categoryStyle,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        decoration: AppDecoration.dropDownBorder,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: DropdownButtonHideUnderline(
                              child: Obx(
                            () => DropdownButton(
                              hint: Text(
                                "Select Category",
                                style: TextStyle(color: ColorConstant.grey),
                              ),
                              isExpanded: true,
                              onChanged: (newvalue) {
                                controller.setCategory(newvalue.toString());
                              },
                              value: controller.category.value,
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
                      Text(
                        'Reminder Title',
                        style: AppStyle.categoryStyle,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: controller.reminderTitleController,
                        decoration: AppDecoration.textfieldDecoration,
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Enter Reminder Title';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            'Alarm at: ' + formattedDate,
                            style: AppStyle.alarmDateTime,
                          ),
                        ],
                      ),
                      SizedBox(height: 13),
                      Text(
                        "Repeat type",
                        style: AppStyle.categoryStyle,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        decoration: AppDecoration.repeatTypeBorder,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8),
                          child: DropdownButtonHideUnderline(
                              child: Obx(
                            () => DropdownButton(
                              hint: Text(
                                " Select Reminder Type",
                                style: TextStyle(color: ColorConstant.grey),
                              ),
                              isExpanded: true,
                              onChanged: (newvalue) {
                                controller.setReminderType(newvalue.toString());
                              },
                              value: controller.reminderType.value,
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
                      Obx(() => controller
                          .renderWidget(controller.reminderType.value)),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        'Notes',
                        style: AppStyle.categoryStyle,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      TextFormField(
                        textInputAction: TextInputAction.done,
                        controller: controller.reminderNoteController,
                        decoration: AppDecoration.textfieldDecoration,
                        maxLines: 5,
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ListTile(
                        onTap: null,
                        contentPadding: EdgeInsets.zero,
                        //leading: Icon(Icons.snooze_outlined),
                        title: Text(
                          "Repeat My Reminder",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        dense: true,
                        // trailing: Obx(() => Switch(
                        //     value: settingController.repeatflag.value,
                        //     onChanged: (val) {
                        //       settingController.repeatChange();
                        //       print(settingController.repeatflag);
                        //     }))
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      // ListTile(
                      //     onTap: null,
                      //     contentPadding: EdgeInsets.zero,
                      //     //leading: Icon(Icons.snooze_outlined),
                      //     title: CustomText(
                      //       text: "Snooze",
                      //       weight: FontWeight.w500,
                      //     ),
                      //     dense: true,
                      //     trailing: Obx(() => Switch(
                      //         value: settingController.snoozeflag.value,
                      //         onChanged: (val) {
                      //           settingController.snoozechange();
                      //           print(settingController.snoozeflag.value);
                      //         }))),

                      // // ==================== My code is start here........  ===================================
                      // Obx(
                      //   () => Visibility(
                      //     visible: settingController.snoozeflag.value,
                      //     child: Row(
                      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //       children:
                      //           // ignore: prefer_const_literals_to_create_immutables
                      //           [
                      //         snooz_type("5", settingController.min5.value),
                      //         snooz_type("10", settingController.min10.value),
                      //         snooz_type("15", settingController.min15.value)
                      //       ],
                      //     ),
                      //   ),
                      // )

// ==================== My code is end here........  ===================================
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
}
