import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  // TextEditingControllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Reactive states
  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;
  var isLoading = false.obs;
  var isAgreed = false.obs;

  // Dispose controllers
  @override
  void onClose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // Validation
  bool validateForm() {
    if (firstNameController.text.isEmpty ||
        lastNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        phoneController.text.isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      Get.snackbar("Missing Info", "Please fill in all fields.",
          backgroundColor: Colors.redAccent.withOpacity(0.2),
          colorText: Colors.black87);
      return false;
    }

    if (!GetUtils.isEmail(emailController.text)) {
      Get.snackbar("Invalid Email", "Please enter a valid email address.",
          backgroundColor: Colors.redAccent.withOpacity(0.2),
          colorText: Colors.black87);
      return false;
    }

    if (passwordController.text.length < 6) {
      Get.snackbar("Weak Password", "Password must be at least 6 characters.",
          backgroundColor: Colors.redAccent.withOpacity(0.2),
          colorText: Colors.black87);
      return false;
    }

    if (passwordController.text != confirmPasswordController.text) {
      Get.snackbar("Password Mismatch", "Both passwords must match.",
          backgroundColor: Colors.redAccent.withOpacity(0.2),
          colorText: Colors.black87);
      return false;
    }

    if (!isAgreed.value) {
      Get.snackbar("Agreement Required",
          "You must agree to the Terms of Service and Privacy Policy.",
          backgroundColor: Colors.redAccent.withOpacity(0.2),
          colorText: Colors.black87);
      return false;
    }

    return true;
  }

  // Register function
  Future<void> register() async {
    if (!validateForm()) return;

    isLoading.value = true;

    try {
      await Future.delayed(const Duration(seconds: 2)); // simulate API delay

      Get.snackbar("Success", "Account created successfully!",
          backgroundColor: Colors.green.withOpacity(0.2),
          colorText: Colors.black87);

      // Example: Navigate to another page
      // Get.offAllNamed('/home');
    } catch (e) {
      Get.snackbar("Error", "Something went wrong. Please try again.",
          backgroundColor: Colors.redAccent.withOpacity(0.2),
          colorText: Colors.black87);
    } finally {
      isLoading.value = false;
    }
  }
}
