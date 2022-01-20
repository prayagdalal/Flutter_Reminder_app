import 'package:get/get.dart';

class AddTaskController extends GetxController {
  var tabIndex = 0.obs;
  var category = 'Warrnty Card'.obs;
  var reminderType = 'Minute'.obs;
  var currentTime = ''.obs;
  var updatedTime = ''.obs;

  void setCategory(String value) {
    category.value = value;
  }

  void setReminderType(String value) {
    reminderType.value = value;
  }

  @override
  void onInit() {
    currentTime.value = DateTime.now().toString();
    super.onInit();
  }

  @override
  void dispose() {
    currentTime ;
    super.dispose();
  }
}
