// lib/app/modules/onboarding/onboarding_view.dart
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voice2gov_app/app/modules/onbordingScreen/controllers/onbording_screen_controller.dart';

class OnbordingScreenView extends StatelessWidget {
  const OnbordingScreenView({super.key});

  final List<OnboardingPage> pages = const [
    OnboardingPage(
      title: "এক টিকানায় সরকারি সেবা",
      subtitle: "আপনার অভিযোগ কেবল কথায় বলুন",
      image: 'assets/bd.svg',
      color: Color(0xFF0B6623), // BD Gov Green
    ),
    OnboardingPage(
      title: "কীভাবে কাজ করে?",
      subtitle: "কথা → পাঠ্য → এআই → বিভাগে পাঠানো",
      image: 'assets/bd.svg',
      color: Color(0xFF6A1B9A), // Solvio Purple
    ),
    OnboardingPage(
      title: "শুরু করুন",
      subtitle: "আপনার ভাষা নির্বাচন করুন",
      image: 'assets/bd.svg',
      color: Color(0xFF1A0033),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnbordingScreenController());

    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            // Page Content
            PageView.builder(
              itemCount: pages.length,
              onPageChanged: (i) => controller.currentPage.value = i,
              itemBuilder: (ctx, i) {
                final page = pages[i];
                return _buildPage(page);
              },
            ),

            // Top Skip Button
            Positioned(
              top: 50,
              right: 20,
              child: TextButton(
                onPressed: controller.skip,
                child: const Text(
                  "Skip",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ),

            // Bottom Dots + Button
            Positioned(
              bottom: 60,
              left: 0,
              right: 0,
              child: Column(
                children: [
                  // Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      pages.length,
                      (i) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: controller.currentPage.value == i ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: controller.currentPage.value == i
                              ? Colors.white
                              : Colors.white38,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Next / Start Button
                  SizedBox(
                    width: 220,
                    child: ElevatedButton(
                      onPressed: controller.nextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,

                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        controller.currentPage.value == pages.length - 1
                            ? "শুরু করুন"
                            : "পরবর্তী",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [page.color, page.color.withOpacity(0.9)],
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 80),

          // SVG Image
          SvgPicture.asset(
            page.image,
            height: 280,
            fit: BoxFit.contain,
            colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),

          const SizedBox(height: 50),

          // Title
          Text(
            page.title,
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // Subtitle
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Text(
              page.subtitle,
              style: GoogleFonts.poppins(fontSize: 16, color: Colors.white70),
              textAlign: TextAlign.center,
            ),
          ),

          const Spacer(),
        ],
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String subtitle;
  final String image;
  final Color color;

  const OnboardingPage({
    required this.title,
    required this.subtitle,
    required this.image,
    required this.color,
  });
}
