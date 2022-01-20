import 'package:flutter/material.dart';
import 'package:reminder_app/utills/colors.dart';

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
                showDatePicker(
                    context: ctx,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2022),
                    lastDate: DateTime(2050));
              },
              child: IgnorePointer(
                child: TextFormField(
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
                showDatePicker(
                    context: ctx,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2022),
                    lastDate: DateTime(2050));
              },
              child: IgnorePointer(
                child: TextFormField(
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
            showTimePicker(context: ctx, initialTime: TimeOfDay.now());
          },
          child: IgnorePointer(
            child: TextFormField(
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
