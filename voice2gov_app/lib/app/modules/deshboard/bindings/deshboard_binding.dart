import 'package:get/get.dart';

import '../controllers/deshboard_controller.dart';

class DeshboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
