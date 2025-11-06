import 'package:get/get.dart';
import 'package:voice2gov_app/app/modules/onbordingScreen/views/onbording_screen_view.dart';

class SplashscreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(Duration(milliseconds: 3500));
    Get.off(() => OnbordingScreenView());
  }
}
