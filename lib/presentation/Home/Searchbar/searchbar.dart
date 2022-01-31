// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_app/utills/colors.dart';
import 'package:reminder_app/utills/customtext.dart';

var category = [
  "Warrnty Card",
  "Coupon",
  "PUC",
  "Property Rent",
  "Premium",
  "Bill Payment",
  "Credit Card",
  "Recharge",
  "EMI",
  "Loan",
];

class SearchBarPage extends StatelessWidget {
  const SearchBarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        title: Center(
          child: CustomText(
            text: 'Search',
            color: white,
            size: 18,
            weight: FontWeight.w800,
          ),
        ),
        actions: [custome_popupmenu()],
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: white,
            )),
      ),
      body: custome_body(),
    );
  }
}

Widget custome_popupmenu() {
  return PopupMenuButton(
    icon: Icon(
      Icons.category,
      color: white,
    ),
    color: white,
    itemBuilder: (context) => category
        .map((item) => PopupMenuItem<String>(
              value: item,
              child: CustomText(
                text: item,
                size: 16,
                weight: FontWeight.w600,
              ),
            ))
        .toList(),
    onSelected: (item) {},
  );
}

Widget custome_body() {
  return Padding(
    padding: const EdgeInsets.only(top:15,left:8,right: 8),
    child: Column(
      children: [
        SizedBox(
            height: 100,
            child: TextFormField(
              textInputAction: TextInputAction.done,
              decoration: getTextBorder(),
            ))
      ],
    ),
  );
}

InputDecoration getTextBorder() {
  return InputDecoration(
    suffixIcon: Icon(
      Icons.search,
      color: green,
    ),
    filled: true,
    hintText: "Search here..",
    fillColor: Colors.grey[50],
    contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: green, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
      borderSide: BorderSide(color: green, width: 1),
    ),
  );
}
