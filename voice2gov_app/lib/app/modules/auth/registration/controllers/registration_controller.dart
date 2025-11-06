// lib/app/modules/registration/registration_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();

  var isLoading = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    super.onClose();
  }

  void register() async {
    if (nameController.text.trim().isEmpty || phoneController.text.trim().isEmpty) {
      Get.snackbar(
        "ত্রুটি",
        "নাম এবং মোবাইল নম্বর আবশ্যক",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      return;
    }

    isLoading(true);
    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    // TODO: Call your real API here
    // final success = await AuthService.register(...);

    isLoading(false);

    Get.snackbar(
      "সফল!",
      "আপনার নিবন্ধন সম্পন্ন হয়েছে",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );

    // Navigate to Home / Dashboard
    Get.offAllNamed('/home'); // <-- change to your route
  }
}