import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:voice2gov_app/app/modules/notification/controllers/notification_controller.dart';
import 'package:voice2gov_app/app/modules/notification/model/notification_model.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF0B6623),
        elevation: 0,
        title: Text(
          "বিজ্ঞপ্তি",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600, color: Colors.white, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          Obx(() => controller.unreadCount > 0
              ? IconButton(
                  icon: const Icon(Icons.mark_email_read, color: Colors.white),
                  onPressed: controller.markAllAsRead,
                )
              : const SizedBox()),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator(color: Color(0xFF0B6623)));
        }

        if (controller.hasError.value || controller.notifications.isEmpty) {
          return _buildEmptyState();
        }

        return RefreshIndicator(
          onRefresh: controller.onRefresh,
          color: const Color(0xFF0B6623),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.notifications.length,
            itemBuilder: (context, index) {
              final noti = controller.notifications[index];
              return _buildNotificationCard(noti, controller);
            },
          ),
        );
      }),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: "https://img.icons8.com/fluency/96/bell.png",
            width: 80,
            height: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text("কোনো বিজ্ঞপ্তি নেই", style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey.shade600)),
          const SizedBox(height: 8),
          Text("আপনার অভিযোগ ও আপডেট এখানে দেখাবে", style: GoogleFonts.poppins(fontSize: 14, color: Colors.grey.shade500), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildNotificationCard(NotificationModel noti, NotificationController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: noti.isRead ? Colors.white : const Color(0xFFE8F5E8),
        borderRadius: BorderRadius.circular(16),
        border: noti.isRead ? null : Border.all(color: const Color(0xFF0B6623).withOpacity(0.3), width: 1.5),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(color: const Color(0xFF0B6623).withOpacity(0.1), shape: BoxShape.circle),
            child: Center(
              child: CachedNetworkImage(
                imageUrl: noti.iconUrl,
                width: 28,
                height: 28,
                placeholder: (_, __) => const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFF0B6623))),
                errorWidget: (_, __, ___) => const Icon(Icons.notifications, size: 28, color: Color(0xFF0B6623)),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(noti.title, style: GoogleFonts.poppins(fontSize: 15, fontWeight: noti.isRead ? FontWeight.w500 : FontWeight.w600, color: const Color(0xFF0B6623))),
                const SizedBox(height: 4),
                Text(noti.message, style: GoogleFonts.poppins(fontSize: 13, color: Colors.black87), maxLines: 2, overflow: TextOverflow.ellipsis),
                const SizedBox(height: 6),
                Text(controller.formatTime(noti.time), style: GoogleFonts.poppins(fontSize: 11, color: Colors.grey.shade600)),
              ],
            ),
          ),

          // Unread Dot
          if (!noti.isRead)
            Container(width: 10, height: 10, decoration: const BoxDecoration(color: Color(0xFF0B6623), shape: BoxShape.circle)),
        ],
      ),
    );
  }
}