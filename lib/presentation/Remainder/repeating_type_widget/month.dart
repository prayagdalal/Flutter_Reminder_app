import 'package:flutter/material.dart';
import 'package:reminder_app/utills/colors.dart';
import 'package:reminder_app/utills/customtext.dart';

Widget month_type(ctx)
{
  return Column(
    // crossAxisAlignment: CrossAxisAlignment.center,
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
            text: "Month",
          ),
        ],
      ),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CustomText(
            text: "Select Date:",
          ),
           Container(
            width: 130,
            child: InkWell(
              onTap: () {
                showDatePicker(
                    context: ctx,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2022),
                    lastDate: DateTime(2050));
              },
              child: IgnorePointer(
                child: TextFormField(
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: green,width: 1.5),
                    ),
                  ),
                ),
              ),
            ),

          ),
      
          MaterialButton(
            color: green,onPressed:(){},
          child: Row(
            children: [
              Icon(Icons.add,color: white,),
              SizedBox(width: 2,),
              CustomText(text: "Add More",color: white,size: 13,),
            ],
          ),)
        ],
      ),

    ],
  );
}