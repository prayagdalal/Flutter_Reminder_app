// To parse this JSON data, do
//
//     final taskModel = taskModelFromJson(jsonString);

// ignore_for_file: prefer_if_null_operators

import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
  TaskModel({
    this.taskId,
    this.taskTitle,
    this.categoryName,
    this.reminderType,
    this.isRepeat,
    this.isSnoozed,
    this.frequency,
    this.isActive,
    this.isComplete,
    this.selectedDays,
    this.customWeek,
    this.customDay,
    this.customMonth,
    this.customMinute,
    this.customHour,
    this.time,
    this.snoozeTime,
    this.updatedTime,
    this.description,
    this.isVibrated,
  });

  int? taskId;
  String? taskTitle;
  String? categoryName;
  String? reminderType;
  int? isRepeat;
  int? isSnoozed;
  int? frequency;
  int? isActive;
  int? isComplete;
  String? selectedDays;
  int? customWeek;
  int? customDay;
  int? customMonth;
  int? customMinute;
  int? customHour;
  String? time;
  int? snoozeTime;
  String? updatedTime;
  String? description;
  int? isVibrated;

  factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        taskId: json["task_id"] == null ? null : json["task_id"],
        taskTitle: json["task_title"] == null ? null : json["task_title"],
        categoryName:
            json["category_name"] == null ? null : json["category_name"],
        reminderType:
            json["reminderType"] == null ? null : json["reminderType"],
        isRepeat: json["isRepeat"] == null ? null : json["isRepeat"],
        isSnoozed: json["isSnoozed"] == null ? null : json["isSnoozed"],
        frequency: json["frequency"] == null ? null : json["frequency"],
        isActive: json["isActive"] == null ? null : json["isActive"],
        isComplete: json["isComplete"] == null ? null : json["isComplete"],
        selectedDays:
            json["selected_days"] == null ? null : json["selected_days"],
        customWeek: json["custom_week"] == null ? null : json["custom_week"],
        customDay: json["custom_day"] == null ? null : json["custom_day"],
        customMonth: json["custom_month"] == null ? null : json["custom_month"],
        customMinute:
            json["custom_minute"] == null ? null : json["custom_minute"],
        customHour: json["custom_hour"] == null ? null : json["custom_hour"],
        time: json["time"] == null
            ? null
            : DateTime.parse(json["time"]).toString(),
        snoozeTime: json["snooze_time"] == null ? null : json["snooze_time"],
        updatedTime: json["updated_time"] == null
            ? null
            : DateTime.parse(json["updated_time"]).toString(),
        description: json["description"] == null ? null : json["description"],
        isVibrated: json["isVibrated"] == null ? null : json["isVibrated"],
      );

  Map<String, dynamic> toJson() => {
        "task_id": taskId == null ? null : taskId,
        "task_title": taskTitle == null ? null : taskTitle,
        "category_name": categoryName == null ? null : categoryName,
        "reminderType": reminderType == null ? null : reminderType,
        "isRepeat": isRepeat == null ? null : isRepeat,
        "isSnoozed": isSnoozed == null ? null : isSnoozed,
        "frequency": frequency == null ? null : frequency,
        "isActive": isActive == null ? null : isActive,
        "isComplete": isComplete == null ? null : isComplete,
        "selected_days": selectedDays == null ? null : selectedDays,
        "custom_week": customWeek == null ? null : customWeek,
        "custom_day": customDay == null ? null : customDay,
        "custom_month": customMonth == null ? null : customMonth,
        "custom_minute": customMinute == null ? null : customMinute,
        "custom_hour": customHour == null ? null : customHour,
        "time": time == null ? null : time,
        "snooze_time": snoozeTime == null ? null : snoozeTime,
        "updated_time": updatedTime == null ? null : updatedTime,
        "description": description == null ? null : description,
        "isVibrated": isVibrated == null ? null : isVibrated,
      };
}
