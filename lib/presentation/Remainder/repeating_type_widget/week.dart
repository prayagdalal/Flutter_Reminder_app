import 'package:flutter/material.dart';
import 'every_widget.dart';
import '../../../utills/colors.dart';
import '../../../utills/customtext.dart';
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
      frequency_input("Week"),
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
