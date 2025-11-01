// lib/app/modules/splash/splash_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:lottie/lottie.dart';
import 'package:voice2gov_app/app/modules/splashscreen/controllers/splashscreen_controller.dart';

class SplashscreenView extends GetView<SplashScreenController> {
  const SplashscreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.greenAccent.shade700,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal:30,),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image.asset(
            //   'assets/logo.jpg',
            //   height: 120,
            // ),
            CircleAvatar(
              backgroundImage: AssetImage('assets/logo.jpg',),
              radius: 80,
            ),
            const SizedBox(height: 40),
            // Lottie.asset(
            //   'assets/animations/mic_pulse.json',
            //   height: 180,
            //   fit: BoxFit.contain,
            // ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Report Issues with Your Voice",
                style: GoogleFonts.inter(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}