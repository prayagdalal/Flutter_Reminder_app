import 'package:flutter/material.dart';
import 'package:reminder_app/core/app_export.dart';
import 'package:reminder_app/core/utils/color_constant.dart';
import 'package:reminder_app/presentation/home_screen/controller/home_controller.dart';
import 'package:reminder_app/presentation/home_screen/widgets/tab_widgets/tabbar.dart';
import 'package:reminder_app/presentation/reminder_screen/controller/reminder_controller.dart';
import 'package:reminder_app/presentation/reminder_screen/reminder_screen.dart';
import 'package:reminder_app/theme/app_style.dart';

class HomeBody extends GetWidget<HomeScreenController> {
  const HomeBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.scaffoldBg,
      appBar: AppBar(
        elevation: 3,
        backgroundColor: ColorConstant.green,
        // ignore: prefer_const_constructors
        title: Text(
          "Reminder App",
          style: AppStyle.appBarTitle,
        ),
        actions: [
          IconButton(
            // ignore: prefer_const_constructors
            constraints: BoxConstraints.tight(Size.fromWidth(30)),

            icon: Icon(
              Icons.search_rounded,
              color: ColorConstant.white,
            ),
            onPressed: () {
              Get.toNamed(AppRoutes.searchScreen);
            },
          ),
          SizedBox(
            width: 20,
          ),
          Padding(
            padding: EdgeInsets.only(right: 8),
            child: IconButton(
              padding: EdgeInsets.all(0),

              // ignore: prefer_const_constructors
              icon: Icon(
                Icons.add_rounded,
                color: ColorConstant.white,
              ),
              onPressed: () {
                // Get.toNamed(AppRoutes.addReminderScreen);
                // Get.find<AddReminderController>().clearAllValues;
                TaskModel addTaskObj = TaskModel();
                Get.toNamed(AppRoutes.addReminderScreen, arguments: {
                  "testArg": addTaskObj,
                });
              },
            ),
          ),
        ],
      ),
      body: tabBar(),
    );
  }
}
