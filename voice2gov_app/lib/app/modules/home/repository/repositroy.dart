import 'package:get/get.dart';

class HomeRepository extends GetConnect {
  // Replace with your real backend URL
  static const String _baseUrl = 'http://localhost:3000';

  Future<Response> sendVoiceText(String text) async {
    return await post(
      '$_baseUrl/api/complaints',
      {
        'reporttext': text,
        // 'language': 'bn',
        // 'timestamp': DateTime.now().toIso8601String(),
      },
      headers: {'Content-Type': 'application/json'},
    );
  }
}
