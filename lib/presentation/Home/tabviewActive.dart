import 'package:flutter/material.dart';
import 'package:reminder_app/presentation/Home/activeList.dart';
import 'package:reminder_app/utills/colors.dart';
import 'package:reminder_app/utills/customtext.dart';

Widget TabviewActive() {
  
  return SingleChildScrollView(
    child: ActiveList(),
  );
}
