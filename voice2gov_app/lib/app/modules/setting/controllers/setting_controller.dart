import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsController extends GetxController {
  final RxString language = "বাংলা".obs;

  void changeLanguage(String lang) {
    language.value = lang;
    Get.snackbar("সফল", "ভাষা পরিবর্তন করা হয়েছে: $lang", backgroundColor: const Color(0xFF0B6623), colorText: Colors.white);
    // TODO: Add actual localization (Get.updateLocale)
  }

  void logout() {
    Get.dialog(
      AlertDialog(
        title: Text("লগ আউট", style: GoogleFonts.poppins(fontWeight: FontWeight.w600)),
        content: Text("আপনি কি নিশ্চিত লগ আউট করতে চান?", style: GoogleFonts.poppins()),
        actions: [
          TextButton(onPressed: Get.back, child: Text("না", style: GoogleFonts.poppins(color: Colors.grey))),
          TextButton(
            onPressed: () {
              Get.back();
              Get.offAllNamed('/login');
            },
            child: Text("হ্যাঁ", style: GoogleFonts.poppins(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}