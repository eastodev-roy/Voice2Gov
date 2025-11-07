import 'package:get/get.dart';

import '../modules/auth/forgetpassword/bindings/forgetpassword_binding.dart';
import '../modules/auth/forgetpassword/views/forgetpassword_view.dart';
import '../modules/auth/login/bindings/login_binding.dart';
import '../modules/auth/login/views/login_view.dart';
import '../modules/auth/registration/bindings/registration_binding.dart';
import '../modules/auth/registration/views/registration_view.dart';
import '../modules/auth/signup/bindings/signup_binding.dart';
import '../modules/auth/signup/views/signup_view.dart';
import '../modules/deshboard/bindings/deshboard_binding.dart';
import '../modules/deshboard/views/deshboard_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/onbordingScreen/bindings/onbording_screen_binding.dart';
import '../modules/onbordingScreen/views/onbording_screen_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/splashscreen/bindings/splashscreen_binding.dart';
import '../modules/splashscreen/views/splashscreen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASHSCREEN;

  static final routes = [
    GetPage(
      name: _Paths.SPLASHSCREEN,
      page: () => const SplashScreen(),
      binding: SplashscreenBinding(),
    ),
    GetPage(name: _Paths.HOME, page: () => HomeView(), binding: HomeBinding()),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRATION,
      page: () => const RegistrationView(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupScreen(),
      binding: SignupBinding(),
    ),
    GetPage(
      name: _Paths.FORGETPASSWORD,
      page: () => const ForgetpasswordView(),
      binding: ForgetpasswordBinding(),
    ),
    GetPage(
      name: _Paths.ONBORDING_SCREEN,
      page: () => const OnbordingScreenView(),
      binding: OnbordingScreenBinding(),
    ),
    GetPage(
      name: _Paths.DESHBOARD,
      page: () => DashboardView(),
      binding: DeshboardBinding(),
    ),
    GetPage(
      name: _Paths.SETTING,
      page: () => SettingsView(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
  ];
}
