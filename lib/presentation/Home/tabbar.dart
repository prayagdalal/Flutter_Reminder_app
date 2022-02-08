// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:reminder_app/utills/colors.dart';
import '../../main.dart';
import 'activeList.dart';

Widget tabBar() {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    await Future.delayed(Duration(milliseconds: 1000));
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    await Future.delayed(Duration(milliseconds: 1000));
    taskController.fetchTasks();
    _refreshController.loadComplete();
  }

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
            SmartRefresher(
                controller: _refreshController,
                enablePullDown: true,
                enablePullUp: false,
                header: WaterDropHeader(),
                dragStartBehavior: DragStartBehavior.start,
                onRefresh: _onRefresh,
                onLoading: _onLoading,
                child: list(1)),
            list(0),
          ],
        ))
      ],
    ),
  );
}
