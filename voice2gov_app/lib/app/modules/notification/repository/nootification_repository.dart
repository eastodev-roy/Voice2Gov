import 'package:get/get.dart';
import 'package:voice2gov_app/app/modules/notification/model/notification_model.dart';

class NotificationRepository extends GetConnect {
  static const String _baseUrl = 'https://your-api.com'; // Replace with real URL

  @override
  void onInit() {
    httpClient.baseUrl = _baseUrl;
    httpClient.timeout = const Duration(seconds: 10);
    super.onInit();
  }

  // GET: Fetch notifications
  Future<List<NotificationModel>> fetchNotifications() async {
    try {
      final response = await get('/api/notifications');
      if (response.statusCode == 200) {
        final List data = response.body['data'] ?? [];
        return data.map((e) => NotificationModel.fromJson(e)).toList();
      } else {
        throw Exception('Failed to load: ${response.statusCode}');
      }
    } catch (e) {
      // Fallback to mock data if API fails
      return _mockNotifications();
    }
  }

  // POST: Mark all as read
  Future<bool> markAllAsRead() async {
    try {
      final response = await post('/api/notifications/mark-read', {});
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // Mock data (for offline/testing)
  List<NotificationModel> _mockNotifications() {
    return [
      NotificationModel(
        id: '1',
        title: "অভিযোগ গৃহীত",
        message: "বিদ্যুৎ সংক্রান্ত অভিযোগ জমা হয়েছে।",
        time: DateTime.now().subtract(const Duration(minutes: 5)),
        iconUrl: "https://img.icons8.com/fluency/48/check-circle.png",
        isRead: false,
      ),
      NotificationModel(
        id: '2',
        title: "সেবা সম্পন্ন",
        message: "পানি সরবরাহ সমস্যা সমাধান।",
        time: DateTime.now().subtract(const Duration(hours: 2)),
        iconUrl: "https://img.icons8.com/fluency/48/ok.png",
        isRead: true,
      ),
    ];
  }
}