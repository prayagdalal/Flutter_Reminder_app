import 'package:reminder_app/core/app_export.dart';
import 'package:reminder_app/presentation/setting_screen/controller/backup_restore_controller.dart';
import 'package:reminder_app/presentation/setting_screen/controller/setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SettingScreenController());
    // Get.put(() => backupRestoreController());
  }
}
