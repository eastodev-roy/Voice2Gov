import 'dart:async';
import 'package:get/get.dart';
import 'package:voice2gov_app/app/modules/onbordingScreen/views/onbording_screen_view.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    startTimer();
  }

  void startTimer() {
    Timer(const Duration(milliseconds: 2500), () {
      // Using Get.offNamed with the defined route to navigate
      // Get.offNamed(Routes.ONBORDING_SCREEN);
      Get.to(()=>OnbordingScreenView());
    });
  }
}
