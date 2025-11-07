import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:voice2gov_app/app/modules/deshboard/controllers/deshboard_controller.dart';

class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B6623),
        elevation: 0,
        title: Text(
          "আপনার সব আবেদন",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Obx(() {
        final totalApplications = controller.totalApplications.value;

        return Column(
          children: [
            // Top Card
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
              decoration: BoxDecoration(
                color: const Color(0xFFE8F5E8),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: const Color(0xFF0B6623), width: 1.5),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "দেখিলকৃত আবেদন",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: const Color(0xFF0B6623),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "মোট আবেদন: $totalApplications টি",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: const Color(0xFF0B6623),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: const BoxDecoration(
                      color: Color(0xFF0B6623),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.description, color: Colors.white, size: 28),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // Empty State Illustration
            CachedNetworkImage(
              imageUrl: "https://i.ibb.co/3h9n8vJ/empty-folder-illustration.png", // Free illustration
              width: 180,
              height: 180,
              placeholder: (_, __) => const CircularProgressIndicator(color: Color(0xFF0B6623)),
              errorWidget: (_, __, ___) => const Icon(Icons.folder_open, size: 120, color: Colors.grey),
            ),

            const SizedBox(height: 24),

            Text(
              "এখনো কোন আবেদন করা হয় নি",
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "আপনার অভিযোগ বা সেবা আবেদন করুন",
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey.shade500,
              ),
              textAlign: TextAlign.center,
            ),

            const Spacer(),
          ],
        );
      }),
    );
  }
}