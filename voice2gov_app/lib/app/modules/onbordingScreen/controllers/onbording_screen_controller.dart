// lib/app/modules/onboarding/onboarding_controller.dart
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnbordingScreenController extends GetxController {
  var currentPage = 0.obs;
  final totalPages = 3;

  void nextPage() {
    if (currentPage.value < totalPages - 1) {
      currentPage.value++;
    } else {
      _completeOnboarding();
    }
  }

  void skip() => _completeOnboarding();

  Future<void> _completeOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenOnboarding', true);
    Get.offAllNamed('/home');
  }
}