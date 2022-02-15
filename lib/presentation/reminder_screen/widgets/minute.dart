// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_app/core/utils/color_constant.dart';
import 'package:reminder_app/presentation/reminder_screen/controller/reminder_controller.dart';
import '../../../main.dart';

class minute_type extends GetWidget<AddReminderController> {
  const minute_type({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              "Every",
            ),
            Container(
              width: 130,
              child: TextFormField(
                controller: controller.minuteController,

                // maxLength: 2,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorConstant.green),
                  ),
                ),
              ),
            ),
            Text(
              "Minute",
            ),
          ],
        )
      ],
    );
  }
}
