// ignore_for_file: curly_braces_in_flow_control_structures, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/presentation/Remainder/remainderBody.dart';
import 'package:reminder_app/utills/colors.dart';

import '../../../main.dart';

Widget custom_type(ctx) {
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            width: 130,
            child: InkWell(
              onTap: () {
                _selectDate(ctx, addTaskController.customFromController);
              },
              child: IgnorePointer(
                child: TextFormField(
                  controller: addTaskController.customFromController,
                  decoration: InputDecoration(
                    labelText: "From",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: green),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 130,
            child: InkWell(
              onTap: () {
                _selectDate(ctx, addTaskController.customToController);
              },
              child: IgnorePointer(
                child: TextFormField(
                  controller: addTaskController.customToController,
                  decoration: InputDecoration(
                    labelText: "To",
                    hintText: "Write short note...",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: green),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      Container(
        width: 150,
        child: InkWell(
          onTap: () {
            _selectTime(ctx, addTaskController.customTimeController);
          },
          child: IgnorePointer(
            child: TextFormField(
              controller: addTaskController.customTimeController,
              decoration: InputDecoration(
                labelText: "Time",
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: green),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}

DateTime selectedDate = DateTime.now();
_selectDate(BuildContext ctx, controller) async {
  DateTime nowyear = DateTime.now();
  String latestyear = DateFormat('yyyy').format(nowyear);
  final DateTime? picked = await showDatePicker(
    context: ctx,
    initialDate: selectedDate, // Refer step 1
    firstDate: DateTime(int.parse(latestyear)),
    lastDate: DateTime(int.parse(latestyear) + 50),
  );
  if (picked != null && picked != selectedDate)
    controller.text = DateFormat('dd MMM yyyy').format(picked);
}

TimeOfDay selectetime = TimeOfDay.now();
_selectTime(BuildContext ctx, controller) async {
  final TimeOfDay? picked = await showTimePicker(
    context: ctx,
    initialTime: TimeOfDay.now(),
  );

  if (picked != null && picked != selectetime) {
    DateTime tempDate = DateFormat("hh:mm")
        .parse(picked.hour.toString() + ":" + picked.minute.toString());
    var dateFormat = DateFormat("h:mm a");
    controller.text = dateFormat.format(tempDate);
  }
}
