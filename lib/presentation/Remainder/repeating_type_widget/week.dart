import 'package:flutter/material.dart';
import 'package:reminder_app/utills/colors.dart';
import 'package:reminder_app/utills/customtext.dart';
import 'package:day_picker/day_picker.dart';

List<DayInWeek> _days = [
  DayInWeek(
    "Sun",
  ),
  DayInWeek(
    "Mon",
  ),
  DayInWeek(
    "Tue",
  ),
  DayInWeek(
    "Wed",
  ),
  DayInWeek(
    "Thu",
  ),
  DayInWeek(
    "Fri",
  ),
  DayInWeek("Sat", isSelected: true),
];

Widget week_type() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
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
              maxLength: 2,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: green),
                ),
              ),
            ),
          ),
          CustomText(
            text: "Week",
          ),
        ],
      ),
      Padding(
        padding: const EdgeInsets.only(left: 22.0),
        child: CustomText(
          text: "Repeat on",
        ),
      ),
      SizedBox(
        height: 6,
      ),
      SelectWeekDays(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        days: _days,
        border: false,
        boxDecoration: BoxDecoration(
          color: green,
          borderRadius: BorderRadius.circular(30.0),
        ),
        onSelect: (values) {
          print(values);
        },
      ),
    ],
  );
}

Widget circle(txt) {
  return Container(
    height: 45,
    width: 45,
    decoration: BoxDecoration(
      border: Border.all(color: green, width: 1.5),
      borderRadius: BorderRadius.circular(20),
    ),
    child: Center(child: CustomText(text: txt)),
  );
}
