// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:reminder_app/utills/colors.dart';
import 'activeList.dart';
Widget tabBar() {
  return DefaultTabController(
    length: 2,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
          child: TabBar(
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                color: green,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(12),
              ),
              labelColor: white,
              unselectedLabelColor: green,
              // ignore: prefer_const_literals_to_create_immutables
              tabs: [
                Tab(
                  text: "Active",
                ),
                // ignore: prefer_const_constructors
                Tab(
                  text: "Done",
                )
              ]),
        ),
        Expanded(
            child: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            list(1),
            list(0),
          ],
        ))
      ],
    ),
  );
}
