// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:reminder_app/presentation/Remainder/remainderBody.dart';
import 'package:reminder_app/utills/colors.dart';
import 'package:reminder_app/utills/customtext.dart';

import '../../../main.dart';

Widget frequency_input(txt) {
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
              controller: addTaskController.frequencyController,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp("[0-9]")),
              ],
              //  ====== This is My code =================
              onChanged: (val) {
                if (val.isNotEmpty) {
                  if ((int.parse(val) == 0 || int.parse(val) >= 60) &&
                      txt == "Minute") {
                    Get.defaultDialog(
                        backgroundColor: transparent,
                        title: "",
                        barrierDismissible: true,
                        content: AlertDialog(
                          insetPadding: EdgeInsets.zero,
                          scrollable: true,
                          content: Row(
                            children: [
                              Icon(
                                Icons.warning_amber,
                                color: green,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text("Minute should range \nbetween 1 to 59"),
                            ],
                          ),
                        ));
                    addTaskController.frequencyController.text = "";
                  } else if ((int.parse(val) == 0 || int.parse(val) >= 24) &&
                      txt == "Hour") {
                    Get.defaultDialog(
                        backgroundColor: transparent,
                        title: "",
                        barrierDismissible: true,
                        content: AlertDialog(
                          insetPadding: EdgeInsets.zero,
                          scrollable: true,
                          content: Row(
                            children: [
                              Icon(
                                Icons.warning_amber,
                                color: green,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text("Hour should range \nbetween 1 to 23"),
                            ],
                          ),
                        ));
                    addTaskController.frequencyController.text = "";
                  } else if ((int.parse(val) == 0 || int.parse(val) > 4) &&
                      txt == "Week") {
                    Get.defaultDialog(
                        backgroundColor: transparent,
                        title: "",
                        barrierDismissible: true,
                        content: AlertDialog(
                          insetPadding: EdgeInsets.zero,
                          scrollable: true,
                          content: Row(
                            // ignore: prefer_const_literals_to_create_immutables
                            children: [
                              Icon(
                                Icons.warning_amber,
                                color: green,
                              ),
                              SizedBox(
                                width: 7,
                              ),
                              Text("Week should range \nbetween 1 to 4"),
                            ],
                          ),
                        ));
                    addTaskController.frequencyController.text = "";
                  }
                }
              },
              //  ============== my code ende here
              validator: (value) {
                if (value == "") {
                  return "Enter Value";
                }
              },
              maxLength: 2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: green),
                ),
              ),
            ),
          ),
          CustomText(
            text: txt,
          ),
        ],
      )
    ],
  );
}
