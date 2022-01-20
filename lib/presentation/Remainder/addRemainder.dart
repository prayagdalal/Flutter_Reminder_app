import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reminder_app/controller/task_controller.dart';
import 'package:reminder_app/presentation/Remainder/remainderBody.dart';
import 'package:reminder_app/utills/colors.dart';
import 'package:reminder_app/utills/customtext.dart';

class add_Remainders extends StatelessWidget {
  const add_Remainders({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskController = Get.put(TaskController());

    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      appBar: AppBar(
        elevation: 3,
        backgroundColor: green,
        // ignore: prefer_const_constructors
        title: CustomText(
          text: 'Add Reminder',
          color: white,
          size: 18,
          weight: FontWeight.w800,
        ),
        leading: IconButton(
          // ignore: prefer_const_constructors
          icon: Icon(
            Icons.arrow_back_ios,
            color: white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: IconButton(
              // ignore: prefer_const_constructors
              constraints: BoxConstraints.tight(Size.fromWidth(30)),
              padding: EdgeInsets.all(0),

              // ignore: prefer_const_constructors
              icon: Icon(
                Icons.check_circle_rounded,
                color: white,
              ),
              onPressed: () {
                //addTAsk();
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(child: remainder_body(context)),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   backgroundColor: green,
      //   child: Icon(
      //     Icons.check,
      //     color: white,
      //   ),
      // ),
    );
  }
}
