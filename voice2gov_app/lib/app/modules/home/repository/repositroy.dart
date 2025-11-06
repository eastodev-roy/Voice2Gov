import 'package:get/get.dart';

class HomeRepository extends GetConnect {
  // Replace with your real backend URL
  static const String _baseUrl = 'https://your-api.com';

  Future<Response> sendVoiceText(String text) async {
    return await post(
      '$_baseUrl/api/voice-complaint',
      {
        'text': text,
        'language': 'bn',
        'timestamp': DateTime.now().toIso8601String(),
      },
      headers: {'Content-Type': 'application/json'},
    );
  }
}
