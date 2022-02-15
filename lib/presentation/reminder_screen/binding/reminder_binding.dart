import 'package:reminder_app/core/app_export.dart';
import 'package:reminder_app/presentation/home_screen/controller/home_controller.dart';
import 'package:reminder_app/presentation/reminder_screen/controller/reminder_controller.dart';

class AddReminderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddReminderController());
  }
}
