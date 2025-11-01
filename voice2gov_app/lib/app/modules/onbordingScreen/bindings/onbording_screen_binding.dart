import 'package:get/get.dart';
import 'package:voice2gov_app/app/modules/onbordingScreen/controllers/onbording_screen_controller.dart';

class OnbordingScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnbordingScreenController>(() => OnbordingScreenController());
  }
}