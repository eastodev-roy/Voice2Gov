// lib/app/modules/splash/splash_binding.dart
import 'package:get/get.dart';
import 'package:voice2gov_app/app/modules/splashscreen/controllers/splashscreen_controller.dart';

class SplashscreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(() => SplashScreenController());
  }
}