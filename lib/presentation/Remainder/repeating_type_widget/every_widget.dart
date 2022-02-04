import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:reminder_app/presentation/Remainder/remainderBody.dart';
import 'package:reminder_app/utills/colors.dart';
import 'package:reminder_app/utills/customtext.dart';

import '../../../main.dart';
Widget frequency_input(txt)
{
  return  Column(
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
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp("[0-9]")),],
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