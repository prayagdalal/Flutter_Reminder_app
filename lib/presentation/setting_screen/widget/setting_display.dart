import 'package:flutter/material.dart';
import 'package:reminder_app/core/app_export.dart';
import 'package:reminder_app/core/utils/color_constant.dart';
import 'package:reminder_app/presentation/reminder_screen/controller/reminder_controller.dart';
import 'package:reminder_app/presentation/search_screen/controller/search_controller.dart';
import 'package:reminder_app/presentation/setting_screen/controller/backup_restore_controller.dart';
import 'package:reminder_app/presentation/setting_screen/controller/setting_controller.dart';
import 'package:reminder_app/theme/app_style.dart';

class SettingBody extends GetWidget<SettingScreenController> {
  const SettingBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            color: ColorConstant.white,
            child: ListTile(
              onTap: () {
                // Get.find<SettingScreenController>().selectetime;
                showTimePicker(initialTime: TimeOfDay.now(), context: context);
              },
              leading: Icon(Icons.av_timer),
              title: Text(
                "Set Default Time",
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              dense: true,
              // trailing: Obx(() => Text(
              //       controller.defaultTime.toString(),
              //       style: TextStyle(color: ColorConstant.green),
              //     ))
            ),
          ),
          Card(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: ColorConstant.white,
            child: ListTile(
              onTap: () {
                showModalBottomSheet(
                    elevation: 10,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20))),
                    context: context,
                    builder: (BuildContext context) {
                      return FractionallySizedBox(
                        heightFactor: 0.4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                // Get.find<backupRestoreController>()
                                //     .uploadToGoogleDrive();
                                controller.backController.value
                                    .uploadToGoogleDrive();
                              },
                              child: SizedBox(
                                height: 100,
                                width: 120,
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.backup,
                                      size: 50,
                                      color: ColorConstant.black,
                                    ),
                                    Text(
                                      "Backup",
                                      style: AppStyle.backupStyle,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.find<backupRestoreController>()
                                    .downloadandsavefile();
                              },
                              child: Container(
                                height: 100,
                                width: 120,
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.restore,
                                      size: 50,
                                      color: ColorConstant.black,
                                    ),
                                    Text(
                                      "Restore",
                                      style: AppStyle.backupStyle,
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
              title: Text(
                "Backup & Restore",
                style: TextStyle(fontWeight: FontWeight.w500),
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
      color: ColorConstant.white,
      child: ListTile(
        leading: Icon(icn),
        title: Text(txt1),
        dense: true,
        trailing: Text(
          txt2,
        ),
      ),
    );
  }
}
