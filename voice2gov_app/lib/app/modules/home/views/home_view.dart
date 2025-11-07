import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:voice2gov_app/app/modules/deshboard/views/deshboard_view.dart';
import 'package:voice2gov_app/app/modules/home/controllers/home_controller.dart';
import 'package:voice2gov_app/app/modules/home/model/model.dart';
import 'package:voice2gov_app/app/modules/notification/views/notification_view.dart';
import 'package:voice2gov_app/app/modules/setting/views/setting_view.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});

  final TextEditingController _searchController = TextEditingController();

  // Page list
  final List<Widget> _pages = [
    const _HomeContent(), // We'll extract content to avoid rebuilding
    const DashboardView(),
    const SettingsView(),
  ];

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HomeController());

    // Sync search bar
    ever(controller.searchText, (String text) {
      _searchController.text = text;
      _searchController.selection = TextSelection.fromPosition(
        TextPosition(offset: text.length),
      );
    });

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B6623),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            radius: 18,
            backgroundColor: Colors.white,
            child: ClipOval(
              child: Image.asset(
                "assets/profile.jpeg",
                width: 36,
                height: 36,
                fit: BoxFit.cover,
              ),
              // child: CachedNetworkImage(
              //   imageUrl: "https://i.pravatar.cc/150?img=3",
              //   placeholder: (context, url) => const CircularProgressIndicator(
              //     strokeWidth: 2,
              //     color: Colors.white,
              //   ),
              //   errorWidget: (context, url, error) =>
              //       const Icon(Icons.person, color: Colors.white70),
              //   width: 36,
              //   height: 36,
              //   fit: BoxFit.cover,
              // ),
            ),
          ),
        ),
        title: Row(
          children: [
            Text(
              "আশিকুর রহমান খান",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              Get.to(() => NotificationView());
            },
          ),
        ],
      ),

      // Main Body with PageView
      body: Obx(
        () => IndexedStack(
          index: controller.selectedIndex.value,
          children: _pages,
        ),
      ),

      // Curved Navigation Bar
      bottomNavigationBar: Obx(
        () => CurvedNavigationBar(
          index: controller.selectedIndex.value,
          height: 60,
          color: Colors.white,
          buttonBackgroundColor: const Color(0xFF0B6623),
          backgroundColor: Colors.transparent,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          onTap: controller.onTabTapped,
          items: [
            _navItem(Icons.home, "হোম", controller.selectedIndex.value == 0),
            _navItem(
              Icons.bookmarks_rounded,
              "ড্যাশবোৰ্ড",
              controller.selectedIndex.value == 1,
            ),
            _navItem(
              Icons.person_2_outlined,
              "প্রোফাইল",
              controller.selectedIndex.value == 2,
            ),
          ],
        ),
      ),
    );
  }

  // Helper: Build Nav Item
  Widget _navItem(IconData icon, String label, bool isActive) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 26,
          color: isActive ? Colors.white : const Color(0xFF0B6623),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: isActive ? Colors.white : const Color(0xFF0B6623),
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

// Extracted Home Content to Prevent Rebuild
class _HomeContent extends StatelessWidget {
  const _HomeContent();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HomeController>();
    final TextEditingController searchCtrl = TextEditingController();

    // Sync search
    ever(controller.searchText, (String text) {
      searchCtrl.text = text;
      searchCtrl.selection = TextSelection.fromPosition(
        TextPosition(offset: text.length),
      );
    });

    return Column(
      children: [
        // Search Bar
        Container(
          color: const Color(0xFF0B6623),
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
          child: TextField(
            controller: searchCtrl,
            onChanged: controller.searchText.call,
            decoration: InputDecoration(
              hintText: "কাঙ্ক্ষিত সেবা খুঁজুন",
              hintStyle: GoogleFonts.poppins(color: Colors.white70),
              prefixIcon: const Icon(Icons.search, color: Colors.white70),
              // suffixIcon: Obx(
              //   () => GestureDetector(
              //     onTap: controller.isListening.value
              //         ? controller.stopListening
              //         : controller.startListening,
              //     child: AnimatedContainer(
              //       duration: const Duration(milliseconds: 300),
              //       padding: const EdgeInsets.all(12),
              //       decoration: BoxDecoration(
              //         shape: BoxShape.circle,
              //         color: controller.isListening.value
              //             ? Colors.red.withOpacity(0.3)
              //             : Colors.white.withOpacity(0.2),
              //       ),
              //       child: Icon(
              //         controller.isListening.value ? Icons.stop : Icons.mic,
              //         color: controller.isListening.value
              //             ? Colors.red
              //             : Colors.white,
              //       ),
              //     ),
              //   ),
              // ),
              filled: true,
              fillColor: Colors.white.withOpacity(0.2),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        // Scrollable Home Content
        Expanded(
          child: RefreshIndicator(
            onRefresh: controller.refreshPage,
            color: const Color(0xFF0B6623),
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Voice Button
                  GestureDetector(
                    onTapDown: (_) => controller.startListening(),
                    onTapUp: (_) => controller.stopListening(),
                    onTapCancel: () => controller.stopListening(),
                    child: Obx(
                      () => AnimatedScale(
                        scale: controller.isListening.value ? 1.15 : 1.0,
                        duration: const Duration(milliseconds: 600),
                        child: Container(
                          width: 120,
                          height: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFE8F5E8),
                            border: Border.all(
                              color: controller.isListening.value
                                  ? Colors.red
                                  : const Color(0xFF0B6623),
                              width: 4,
                            ),
                            boxShadow: controller.isListening.value
                                ? [
                                    BoxShadow(
                                      color: Colors.red.withOpacity(0.4),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                    ),
                                  ]
                                : null,
                          ),
                          child: Center(
                            child: Icon(
                              Icons.mic,
                              size: 50,
                              color: controller.isListening.value
                                  ? Colors.red
                                  : const Color(0xFF0B6623),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Obx(
                    () => Text(
                      controller.isListening.value
                          ? "শুনছি..."
                          : "ভয়েস দিয়ে বলুন",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: controller.isListening.value
                            ? Colors.red
                            : Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Transcription
                  Obx(
                    () => controller.recognizedText.value.isNotEmpty
                        ? Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(bottom: 16),
                            decoration: BoxDecoration(
                              color: Colors.green.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.green),
                            ),
                            child: Text(
                              "শুনেছি: ${controller.recognizedText.value}",
                              style: GoogleFonts.poppins(
                                fontSize: 15,
                                color: const Color(0xFF0B6623),
                                fontWeight: FontWeight.w500,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          )
                        : const SizedBox(),
                  ),

                  Text(
                    "অভিযোগের চেষ্টা সমূহ",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0B6623),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Service Grid
                  Obx(
                    () => GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 3,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.1,
                      children: controller.filteredServices
                          .map((service) => _buildServiceCard(service))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildServiceCard(ServiceModel service) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(
          //   service.icon,
          //   width: 36,
          //   height: 36,
          //   color: const Color(0xFF0B6623),
          // ),
          const SizedBox(height: 8),
          Text(
            service.title,
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
