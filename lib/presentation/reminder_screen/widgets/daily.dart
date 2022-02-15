import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/core/app_export.dart';
import 'package:reminder_app/core/utils/color_constant.dart';
import 'package:reminder_app/presentation/reminder_screen/reminder_screen.dart';
import 'package:reminder_app/presentation/setting_screen/controller/setting_controller.dart';
import 'package:reminder_app/theme/app_style.dart';

class daily_type extends GetWidget<SettingScreenController> {
  daily_type({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                  color: ColorConstant.green,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Your Reminder Will Pop-up on ',
                          style: AppStyle.dialyTypeTextStyle,
                        ),
                        Text(
                          "abc",
                          // taskobj.selectedDays == null
                          //     ? controller.defaultTime.toString()
                          //     : controller.taskTime.toString(),
                          style: AppStyle.dialyTypePopUpTextStyle,
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
        initialTime:
            controller.stringToTimeOfDay(controller.defaultTime.value));

    if (picked != null && picked != selectetime) {
      DateTime tempDate = DateFormat("hh:mm")
          .parse(picked.hour.toString() + ":" + picked.minute.toString());
      var dateFormat = DateFormat("h:mm a");
      controller.defaultTime.value = dateFormat.format(tempDate);
      // print(settingController.defaultTime.value);
      var taskController2 = SharedPrefrences.setSession(
          "SessionKey", dateFormat.format(tempDate));
    }
  }
}
