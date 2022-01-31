// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/presentation/Remainder/remainderBody.dart';
import 'package:reminder_app/presentation/Remainder/repeating_type_widget/every_widget.dart';
import 'package:reminder_app/utills/colors.dart';
import 'package:reminder_app/utills/customtext.dart';

Widget month_type(ctx) {
  return Column(
    // crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      frequency_input("Month"),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomText(
            text: "Select Date:",
          ),
          Container(
            width: 130,
            child: InkWell(
              onTap: ()  {
                _selectDate(ctx);
              },
              child: IgnorePointer(
                child: TextFormField(
                  controller: addTaskController.selectedDateController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: green, width: 1.5),
                    ),
                  ),
                ),
              ),
            ),
          ),
          MaterialButton(
            color: green,
            onPressed: () {},
            child: Row(
              children: [
                Icon(
                  Icons.add,
                  color: white,
                ),
                SizedBox(
                  width: 2,
                ),
                CustomText(
                  text: "Add More",
                  color: white,
                  size: 13,
                ),
              ],
            ),
          )
        ],
      ),
    ],
  );
}

DateTime selectedDate = DateTime.now();
_selectDate(BuildContext ctx) async {
  DateTime nowyear = DateTime.now();
  String latestyear = DateFormat('yyyy').format(nowyear);
  final DateTime? picked = await showDatePicker(
    context: ctx,
    initialDate: selectedDate, // Refer step 1
    firstDate: DateTime(int.parse(latestyear)),
    lastDate: DateTime(int.parse(latestyear) + 50),
  );
  if (picked != null && picked != selectedDate)
    addTaskController.selectedDateController.text =
        DateFormat('dd MMM').format(picked);
}
