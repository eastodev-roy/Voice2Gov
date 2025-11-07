import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:voice2gov_app/app/modules/home/model/model.dart';
import 'package:voice2gov_app/app/modules/home/repository/repositroy.dart';

class HomeController extends GetxController {
  // === UI State ===
  final selectedIndex = 0.obs;
  final isListening = false.obs;
  final recognizedText = ''.obs;
  final volumeLevel = 0.0.obs;
  final searchText = ''.obs;

  // === Speech ===
  final SpeechToText _speechToText = SpeechToText();
  final isSpeechAvailable = false.obs;

  // === Volume Simulation ===
  Timer? _volumeSimTimer;
  final Random _random = Random();

  // === Repository ===
  final HomeRepository _repository = HomeRepository();

  // === Static Services (Local Assets) ===
  final List<ServiceModel> services = [
    ServiceModel(
      title: "জেলা প্রশাসনের সেবাসমূহ",

      keywords: ["জেলা", "প্রশাসন", "সেবা", "ডিসি"],
    ),
    ServiceModel(
      title: "শিক্ষা সম্পর্কিত",

      keywords: ["শিক্ষা", "স্কুল", "কলেজ", "পড়াশোনা"],
    ),
    ServiceModel(
      title: "কৃষি, মৎস্য ও প্রাণিসম্পদ",

      keywords: ["কৃষি", "মৎস্য", "প্রাণি", "ফসল"],
    ),
    ServiceModel(title: "ডেসকো", keywords: ["ডেসকো", "বিদ্যুৎ", "বিল", "লাইট"]),
    ServiceModel(
      title: "স্বাস্থ্য",

      keywords: ["স্বাস্থ্য", "ডাক্তার", "হাসপাতাল", "ঔষধ"],
    ),
    ServiceModel(
      title: "বিদেশগামী সার্টিফিকেট",

      keywords: ["বিদেশ", "সার্টিফিকেট", "সত্যায়ন", "পাসপোর্ট"],
    ),
  ];

  final RxList<ServiceModel> filteredServices = <ServiceModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    filteredServices.assignAll(services);
    _initSpeech();
  }

  @override
  void onClose() {
    _volumeSimTimer?.cancel();
    super.onClose();
  }

  // ─── Initialize Speech ───
  Future<void> _initSpeech() async {
    isSpeechAvailable.value = await _speechToText.initialize(
      onError: (error) =>
          Get.snackbar("ত্রুটি", "স্পিচ সার্ভিসে সমস্যা: ${error.errorMsg}"),
      onStatus: (status) => print('Speech status: $status'),
    );
  }

  // ─── Start Listening ───
  Future<void> startListening() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      Get.snackbar("অনুমতি", "মাইক্রোফোন অনুমতি দিন");
      return;
    }

    if (!isSpeechAvailable.value || isListening.value) return;

    isListening.value = true;
    recognizedText.value = '';
    searchText.value = '';
    volumeLevel.value = 0.0;
    _startVolumeSimulation();

    await _speechToText.listen(
      onResult: (result) {
        recognizedText.value = result.recognizedWords;
        searchText.value = result.recognizedWords;
        _filterServices(result.recognizedWords);

        if (result.finalResult) {
          _onFinalResult(result.recognizedWords);
        }
      },
      localeId: 'bn_BD',
      listenFor: const Duration(seconds: 30),
      pauseFor: const Duration(seconds: 5),
      partialResults: true,
    );
  }

  // ─── Stop Listening ───
  Future<void> stopListening() async {
    if (!isListening.value) return;
    await _speechToText.stop();
    isListening.value = false;
    volumeLevel.value = 0.0;
    _volumeSimTimer?.cancel();
  }

  // ─── Volume Simulation ───
  void _startVolumeSimulation() {
    _volumeSimTimer?.cancel();
    _volumeSimTimer = Timer.periodic(const Duration(milliseconds: 100), (
      timer,
    ) {
      if (!isListening.value) {
        timer.cancel();
        volumeLevel.value = 0.0;
        return;
      }
      final base = 0.3 + _random.nextDouble() * 0.6;
      final noise = _random.nextDouble() * 0.2;
      volumeLevel.value = (base + noise).clamp(0.0, 1.0);
    });
  }

  // ─── Filter Services ───
  void _filterServices(String query) {
    if (query.trim().isEmpty) {
      filteredServices.assignAll(services);
      return;
    }
    final lowerQuery = query.toLowerCase();
    final matches = services
        .where(
          (s) =>
              s.title.toLowerCase().contains(lowerQuery) ||
              s.keywords.any((k) => lowerQuery.contains(k.toLowerCase())) ||
              s.keywords.any((k) => k.toLowerCase().contains(lowerQuery)),
        )
        .toList();
    filteredServices.assignAll(matches);
  }

  // ─── Final Result: Match + Send to Backend ───
  void _onFinalResult(String text) async {
    if (text.trim().isEmpty) return;

    searchText.value = text;
    final matched = _findBestService(text);
    if (matched != null) {
      Get.snackbar(
        "সেবা ম্যাচ হয়েছে!",
        "আপনি বলেছেন: ${matched.title}",
        backgroundColor: const Color(0xFF0B6623),
        colorText: Colors.white,
      );
    }

    await _sendToBackend(text); // Sends to your API
  }

  ServiceModel? _findBestService(String text) {
    text = text.toLowerCase();
    ServiceModel? best;
    int max = 0;
    for (final s in services) {
      int count = s.keywords
          .where((k) => text.contains(k.toLowerCase()))
          .length;
      if (count > max) {
        max = count;
        best = s;
      }
    }
    return max > 0 ? best : null;
  }

  // ─── Send to Backend[](http://localhost:3000/api/complaints) ───
  Future<void> _sendToBackend(String text) async {
    try {
      final response = await _repository.sendVoiceText(text);
      if (response.statusCode == 200 || response.statusCode == 201) {
        Get.snackbar(
          "সফল",
          "আপনার অভিযোগ জমা হয়েছে!",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar("ব্যর্থ", "সার্ভারে সমস্যা: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("ত্রুটি", "নেটওয়ার্ক সমস্যা: $e");
    }
  }

  // ─── Pull-to-Refresh ───
  Future<void> refreshPage() async {
    recognizedText.value = '';
    searchText.value = '';
    isListening.value = false;
    volumeLevel.value = 0.0;
    _volumeSimTimer?.cancel();

    await _initSpeech();
    filteredServices.assignAll(services);

    await Future.delayed(const Duration(milliseconds: 800));
  }

  // ─── Bottom Nav ───
  void onTabTapped(int index) => selectedIndex.value = index;
}
