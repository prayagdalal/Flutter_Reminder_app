import 'package:flutter/material.dart';
import '../../../utills/colors.dart';
import '../../../utills/customtext.dart';
Widget hour_type()
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
              maxLength: 2,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: green),
                ),
              ),
            ),
          ),
          CustomText(
            text: "Hour",
          ),
        ],
      )
    ],
  );
}