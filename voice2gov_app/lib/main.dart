import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app/routes/app_pages.dart'; // Only this is needed

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const Voice2GovApp());
}

class Voice2GovApp extends StatelessWidget {
  const Voice2GovApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Voice2Gov",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL, // <-- Use AppPages.INITIAL
      getPages: AppPages.routes,
      theme: ThemeData(
        primarySwatch: Colors.purple,
        textTheme: GoogleFonts.poppinsTextTheme(),
        scaffoldBackgroundColor: const Color(0xFFF8F9FA),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}
