import 'package:day_picker/day_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'every_widget.dart';
import '../../../utills/colors.dart';
import '../../../utills/customtext.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

List<Widget> date =
    List.generate(31, (index) => CustomText(text: (index + 1).toString()));
List<Widget> month = [
  CustomText(
    text: "Jan",
  ),
  CustomText(
    text: "Feb",
  ),
  CustomText(
    text: "Mar",
  ),
  CustomText(
    text: "Apr",
  ),
  CustomText(
    text: "May",
  ),
  CustomText(
    text: "Jun",
  ),
  CustomText(
    text: "Jul",
  ),
  CustomText(
    text: "Aug",
  ),
  CustomText(
    text: "Sep",
  ),
  CustomText(
    text: "Oct",
  ),
  CustomText(
    text: "Nov",
  ),
  CustomText(
    text: "Dec",
  ),
];

Widget year_type(ctx) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    frequency_input("Year"),
      SizedBox(
        height: 5,
      ),
      SizedBox(
        height: 5,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              CustomText(text: "Date"),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 100,
                  width: 100,
                  child: ListWheelScrollView(
                    itemExtent: 32,
                    children: date,
                    physics: FixedExtentScrollPhysics(),
                    diameterRatio: 1.5,
                    squeeze: 0.8,
                    useMagnifier: true,
                    magnification: 1.5,
                  )),
            ],
          ),
          Column(
            children: [
              CustomText(text: "Month"),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                  height: 100,
                  width: 100,
                  child: ListWheelScrollView(
                      physics: FixedExtentScrollPhysics(),
                      diameterRatio: 1.5,
                      squeeze: 0.8,
                      useMagnifier: true,
                      magnification: 1.5,
                      itemExtent: 31,
                      children: month)),
            ],
          ),
        ],
      ),
      SizedBox(
        height: 3,
      ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 130,
              child: MaterialButton(
                
                  color: green,onPressed:(){},
                child: Row(
                  children: [
                    Icon(Icons.add,color: white,),
                    SizedBox(width: 2,),
                    CustomText(text: "Add More",color: white,size: 13,),
                  ],
                ),),
            ),
          ],
        )
      

    ],
  );
}
