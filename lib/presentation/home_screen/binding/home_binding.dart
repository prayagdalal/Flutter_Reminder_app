import 'package:reminder_app/core/app_export.dart';
import 'package:reminder_app/network/controller/life_cycle_controller.dart';
import 'package:reminder_app/presentation/home_screen/controller/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeScreenController());
    Get.lazyPut(() => LifeCycleController());
  }
}
