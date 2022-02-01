// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/controller/add_taskController.dart';
import 'package:reminder_app/controller/backup_restoreController.dart';
import 'package:reminder_app/controller/setting_controller.dart';
import 'package:reminder_app/main.dart';
import 'package:reminder_app/network/session.dart';
import 'package:reminder_app/utills/colors.dart';
import 'package:reminder_app/utills/customtext.dart';

var settingController = Get.put(SettingController());
var backup_restoreController = Get.put(backupRestoreController());

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffeeeeee),
      appBar: AppBar(
        elevation: 3,
        backgroundColor: green,
        title: CustomText(
          text: 'Settings',
          color: white,
          size: 18,
          weight: FontWeight.w800,
        ),
      ),
      body: settinglists(context),
    );
  }
}

Widget settinglists(ctx) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Column(
      children: [
        SizedBox(
          height: 5,
        ),
        Card(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: white,
          child: ListTile(
              onTap: () {
                _selectTime(ctx);
                // showTimePicker(context: ctx, initialTime: TimeOfDay.now());
              },
              leading: Icon(Icons.av_timer),
              title: CustomText(
                text: "Set Default Time",
                weight: FontWeight.w500,
              ),
              dense: true,
              trailing: Obx(() => CustomText(
                    text: settingController.defaultTime.toString(),
                    color: green,
                  ))),
        ),
        Card(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: white,
          child: ListTile(
              onTap: () {},
              leading: Icon(Icons.snooze),
              title: CustomText(
                text: "Default Snooze",
                weight: FontWeight.w500,
              ),
              dense: true,
              trailing: Obx(() => Switch(
                  value: settingController.snoozeflag.value,
                  onChanged: (val) {
                    settingController.snoozechange();
                  }))),
        ),
        Card(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: white,
            child: ListTile(
                onTap: () {},
                leading: Icon(Icons.vibration),
                title: CustomText(
                  text: "Vibration",
                  weight: FontWeight.w500,
                ),
                dense: true,
                trailing: Obx(() => Switch(
                    value: settingController.vibrationflag.value,
                    onChanged: (val) {
                      settingController.vibrationchange();
                    })))),
        Card(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: white,
          child: ListTile(
            onTap: () {
              showModalBottomSheet(
                  elevation: 10,
                  isScrollControlled: true,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20))),
                  context: ctx,
                  builder: (BuildContext context) {
                    return FractionallySizedBox(
                      heightFactor: 0.4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              backup_restoreController.uploadToGoogleDrive();
                            },
                            child: SizedBox(
                              height: 100,
                              width: 120,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.backup,
                                    size: 50,
                                    color: black,
                                  ),
                                  CustomText(
                                    text: "Backup",
                                    size: 18,
                                    color: green,
                                    weight: FontWeight.bold,
                                  )
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              backup_restoreController.downloadandsavefile();
                            },
                            child: Container(
                              height: 100,
                              width: 120,
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.restore,
                                    size: 50,
                                    color: black,
                                  ),
                                  CustomText(
                                    text: "Restore",
                                    size: 18,
                                    color: green,
                                    weight: FontWeight.bold,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
            leading: Icon(Icons.backup),
            title: CustomText(
              text: "Backup & Restore",
              weight: FontWeight.w500,
            ),
            dense: true,
          ),
        )
      ],
    ),
  );
}

Widget customerow(icn, txt1, txt2) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    color: white,
    child: ListTile(
      leading: Icon(icn),
      title: CustomText(text: txt1),
      dense: true,
      trailing: CustomText(
        text: txt2,
      ),
    ),
  );
}

TimeOfDay selectetime = TimeOfDay.now();
_selectTime(BuildContext ctx) async {
  final TimeOfDay? picked = await showTimePicker(
      context: ctx,
      initialTime: settingController
          .stringToTimeOfDay(settingController.defaultTime.value));

  if (picked != null && picked != selectetime) {
    DateTime tempDate = DateFormat("hh:mm")
        .parse(picked.hour.toString() + ":" + picked.minute.toString());
    var dateFormat = DateFormat("h:mm a");
    settingController.defaultTime.value = dateFormat.format(tempDate);
    // print(settingController.defaultTime.value);
    taskController.setSession(dateFormat.format(tempDate));
  }
}
