import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:googleapis/calendar/v3.dart';
import 'package:reminder_app/core/utils/color_constant.dart';
import 'package:reminder_app/presentation/reminder_screen/controller/reminder_controller.dart';
import '../../../main.dart';

class frequency_input extends GetWidget<AddReminderController> {
  const frequency_input({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var txt;
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
                controller: controller.frequencyController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                ],
                //  ====== This is My code =================
                onChanged: (val) {
                  if (val.isNotEmpty) {
                    if ((int.parse(val) == 0 || int.parse(val) >= 60) &&
                        txt == "Minute") {
                      Get.defaultDialog(
                          backgroundColor: ColorConstant.transparent,
                          title: "",
                          barrierDismissible: true,
                          content: AlertDialog(
                            insetPadding: EdgeInsets.zero,
                            scrollable: true,
                            content: Row(
                              children: [
                                Icon(
                                  Icons.warning_amber,
                                  color: ColorConstant.green,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Text("Minute should range \nbetween 1 to 59"),
                              ],
                            ),
                          ));
                      controller.frequencyController.text = "";
                    } else if ((int.parse(val) == 0 || int.parse(val) >= 24) &&
                        txt == "Hour") {
                      Get.defaultDialog(
                          backgroundColor: ColorConstant.transparent,
                          title: "",
                          barrierDismissible: true,
                          content: AlertDialog(
                            insetPadding: EdgeInsets.zero,
                            scrollable: true,
                            content: Row(
                              children: [
                                Icon(
                                  Icons.warning_amber,
                                  color: ColorConstant.green,
                                ),
                                SizedBox(
                                  width: 7,
                                ),
                                Text("Hour should range \nbetween 1 to 23"),
                              ],
                            ),
                          ));
                      controller.frequencyController.text = "";
                    }
                  }
                },
                //  ============== my code ende here
                validator: (value) {
                  return "Enter Value";
                },
                maxLength: 2,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: ColorConstant.green),
                  ),
                ),
              ),
            ),
            Text(
              txt,
            ),
          ],
        )
      ],
    );
  }
}
