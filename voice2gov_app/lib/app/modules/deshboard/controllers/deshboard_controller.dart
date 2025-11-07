import 'package:get/get.dart';

class DashboardController extends GetxController {
  final RxInt totalApplications = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchApplications();
  }

  Future<void> fetchApplications() async {
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    totalApplications.value = 0; // Initially 0
  }

  // Call this when a new application is submitted
  void addApplication() {
    totalApplications.value++;
  }
}