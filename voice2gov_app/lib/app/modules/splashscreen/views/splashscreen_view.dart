import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice2gov_app/app/modules/splashscreen/controllers/splashscreen_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Inject SplashController
    Get.put(SplashscreenController());

    return Scaffold(
      backgroundColor: const Color(0xFFF1FAF6),
      // backgroundColor: const Color(0xff16A469).withAlpha(50),
      // backgroundColor: Colors.green.withOpacity(0.8),
      body: const _AnimatedSplash(),
    );
  }
}

class _AnimatedSplash extends StatefulWidget {
  const _AnimatedSplash();

  @override
  State<_AnimatedSplash> createState() => _AnimatedSplashState();
}

class _AnimatedSplashState extends State<_AnimatedSplash>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late Animation<double> _logoOpacity;
  late Animation<Offset> _logoSlide;
  late Animation<double> _logoScale;

  String _fullText = "Voice to Gov";
  String _displayedText = "";

  @override
  void initState() {
    super.initState();

    // Logo animation setup
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _logoOpacity = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeOut));

    _logoSlide = Tween<Offset>(
      begin: const Offset(0, 0.4),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _logoController, curve: Curves.easeOut));

    _logoScale = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.easeOutBack),
    );

    // Start logo animation, then trigger text typing
    _logoController.forward().then((_) {
      Future.delayed(const Duration(milliseconds: 400), _startTypingAnimation);
    });
  }

  void _startTypingAnimation() async {
    for (int i = 0; i < _fullText.length; i++) {
      await Future.delayed(const Duration(milliseconds: 120));
      setState(() {
        _displayedText = _fullText.substring(0, i + 1);
      });
    }
  }

  @override
  void dispose() {
    _logoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo animation
          SlideTransition(
            position: _logoSlide,
            child: FadeTransition(
              opacity: _logoOpacity,
              child: ScaleTransition(
                scale: _logoScale,
                child: Image.asset("assets/logo.png", height: 420, width: 420),
              ),
            ),
          ),
          const SizedBox(height: 25),
          // Typing text animation
          // Text.rich(
          //   TextSpan(
          //     children: [
          //       TextSpan(
          //         text: _displayedText.contains("to Gov")
          //             ? _displayedText.substring(
          //                 0,
          //                 _displayedText.length >= 5
          //                     ? 4
          //                     : _displayedText.length,
          //               )
          //             : _displayedText,
          //         style: GoogleFonts.inter(
          //           color: Colors.black,
          //           fontSize: 32,
          //           fontWeight: FontWeight.w700,
          //         ),
          //       ),
          //       if (_displayedText.length > 5)
          //         TextSpan(
          //           text: _displayedText.substring(4),
          //           style: GoogleFonts.inter(
          //             color: Colors.green,
          //             fontSize: 32,
          //             fontWeight: FontWeight.w700,
          //           ),
          //         ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
