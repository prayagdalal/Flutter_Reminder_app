// ignore_for_file: prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:reminder_app/utills/colors.dart';
import 'package:reminder_app/utills/customtext.dart';

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
              showTimePicker(context: ctx, initialTime: TimeOfDay.now());
            },
            leading: Icon(Icons.av_timer),
            title: CustomText(
              text: "Set Default Time",
              weight: FontWeight.w500,
            ),
            dense: true,
            trailing: CustomText(text: "9:00 AM"),
          ),
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
              trailing: Switch(value: false, onChanged: (val) {})),
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
              trailing: Switch(value: false, onChanged: (val) {})),
        ),
        Card(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          color: white,
          child: ListTile(
            onTap: () {},
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
