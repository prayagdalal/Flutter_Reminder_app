import 'package:reminder_app/core/app_export.dart';
import 'package:reminder_app/presentation/home_screen/controller/home_controller.dart';
import 'package:reminder_app/presentation/search_screen/controller/search_controller.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SearchController());
  }
}
