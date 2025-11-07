import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:voice2gov_app/app/modules/setting/controllers/setting_controller.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SettingsController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "মেনু",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            color: Colors.black87,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),

            // ব্যক্তিগত তথ্য
            _buildSectionTitle("ব্যক্তিগত তথ্য"),
            _buildListTile(
              icon: Icons.person_outline,
              title: "প্রোফাইল",
              onTap: () => Get.toNamed('/profile'),
            ),
             Divider(height: 1, color: Colors.grey.shade300),

            const SizedBox(height: 16),

            // ড্যাশবোর্ড
            _buildSectionTitle("ড্যাশবোর্ড"),
            _buildListTile(
              icon: Icons.description_outlined,
              title: "আবেদনের বর্তমান অবস্থা",
              onTap: () => Get.toNamed('/application-status'),
            ),
             Divider(height: 1, color: Colors.grey.shade300),
            _buildListTile(
              icon: Icons.grid_view,
              title: "সব সেবা তালিকা",
              onTap: () => Get.toNamed('/services'),
            ),
             Divider(height: 1, color: Colors.grey.shade300),

            const SizedBox(height: 16),

            // সেটিংস
            _buildSectionTitle("সেটিংস"),
            _buildExpandableTile(
              icon: Icons.language,
              title: "ভাষা",
              options: const ["বাংলা", "English"],
              selected: controller.language.value,
              onSelect: (val) => controller.changeLanguage(val),
            ),
             Divider(height: 1, color: Colors.grey.shade300),
            _buildExpandableTile(
              icon: Icons.help_outline,
              title: "সাহায্য ও অভিযোগ",
              options: const ["অভিযোগ জমা দিন", "সাহায্য কেন্দ্র"],
              selected: null,
              onSelect: (val) {
                if (val == "অভিযোগ জমা দিন") Get.toNamed('/feedback');
                if (val == "সাহায্য কেন্দ্র") Get.toNamed('/help');
              },
            ),
             Divider(height: 1, color: Colors.grey.shade300),

            const SizedBox(height: 24),

            // লগ আউট
            Center(
              child: TextButton(
                onPressed: controller.logout,
                child: Text(
                  "লগ আউট",
                  style: GoogleFonts.poppins(
                    color: Colors.red.shade600,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, bottom: 8),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: const Color(0xFF0B6623),
        ),
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFF0B6623), size: 24),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 15, color: Colors.black87),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    );
  }

  Widget _buildExpandableTile({
    required IconData icon,
    required String title,
    required List<String> options,
    required String? selected,
    required Function(String) onSelect,
  }) {
    return ExpansionTile(
      leading: Icon(icon, color: const Color(0xFF0B6623), size: 24),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 15, color: Colors.black87),
      ),
      childrenPadding: const EdgeInsets.only(left: 56),
      collapsedBackgroundColor: Colors.white,
      backgroundColor: Colors.white,
      children: options.map((opt) {
        return ListTile(
          title: Text(
            opt,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: selected == opt ? const Color(0xFF0B6623) : Colors.black87,
              fontWeight: selected == opt ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
          trailing: selected == opt ? const Icon(Icons.check, color: Color(0xFF0B6623)) : null,
          onTap: () => onSelect(opt),
        );
      }).toList(),
    );
  }
}