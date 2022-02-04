// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_app/controller/add_taskController.dart';
import 'package:reminder_app/presentation/Remainder/remainderBody.dart';
import 'package:reminder_app/utills/colors.dart';
import 'package:reminder_app/utills/customtext.dart';

import '../../../main.dart';

Widget minute_type() {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomText(
            text: "Every",
          ),
          Container(
            width: 130,
            child: TextFormField(
              controller: addTaskController.minuteController,

              // maxLength: 2,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: green),
                ),
              ),
            ),
          ),
          CustomText(
            text: "Minute",
          ),
        ],
      )
    ],
  );
}
