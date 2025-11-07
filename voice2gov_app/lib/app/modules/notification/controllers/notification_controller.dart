import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice2gov_app/app/modules/notification/model/notification_model.dart';
import 'package:intl/intl.dart';
import 'package:voice2gov_app/app/modules/notification/repository/nootification_repository.dart';

class NotificationController extends GetxController {
  final NotificationRepository _repository = NotificationRepository();

  // State
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  // Fetch from API
  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;
      hasError.value = false;
      final data = await _repository.fetchNotifications();
      notifications.assignAll(data);
    } catch (e) {
      hasError.value = true;
      Get.snackbar("ত্রুটি", "বিজ্ঞপ্তি লোড করা যায়নি");
    } finally {
      isLoading.value = false;
    }
  }

  // Mark all as read
  Future<void> markAllAsRead() async {
    final success = await _repository.markAllAsRead();
    if (success) {
      notifications.assignAll(
        notifications.map((n) => n.copyWith(isRead: true)).toList(),
      );
      Get.snackbar("সফল", "সকল বিজ্ঞপ্তি পঠিত", backgroundColor:  Color(0xFF0B6623), colorText: Colors.white);
    }
  }

  // Pull-to-refresh
  Future<void> onRefresh() async {
    await fetchNotifications();
  }

  // Format time in Bengali
  String formatTime(DateTime time) {
    final now = DateTime.now();
    final diff = now.difference(time);

    if (diff.inMinutes < 1) return "এইমাত্র";
    if (diff.inMinutes < 60) return "${diff.inMinutes} মিনিট আগে";
    if (diff.inHours < 24) return "${diff.inHours} ঘণ্টা আগে";
    if (diff.inDays < 7) return "${diff.inDays} দিন আগে";

    return DateFormat('dd MMM, yyyy').format(time);
  }

  // Unread count
  int get unreadCount => notifications.where((n) => !n.isRead).length;
}

// Extension for copyWith
extension on NotificationModel {
  NotificationModel copyWith({bool? isRead}) {
    return NotificationModel(
      id: id,
      title: title,
      message: message,
      time: time,
      iconUrl: iconUrl,
      isRead: isRead ?? this.isRead,
    );
  }
}