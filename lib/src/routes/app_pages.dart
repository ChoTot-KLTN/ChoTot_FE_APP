import 'package:chotot_app/src/app.dart';
import 'package:chotot_app/src/pages/authentication/login/login_page.dart';
import 'package:chotot_app/src/pages/authentication/register/register_page.dart';
import 'package:chotot_app/src/pages/authentication/verify/otp_verifycation_page.dart';
import 'package:chotot_app/src/routes/app_routes.dart';
import 'package:get/get.dart';

class AppPages {
  static const INITIAL = Routes;
  static final routes = [
    GetPage(name: Routes.ROOT, page: () => AppChoTot(), children: []),
    GetPage(name: Routes.LOGIN, page: () => LoginScreen(), children: []),
    GetPage(name: Routes.REGISTER, page: () => RegisterScreen(), children: []),
    GetPage(
        name: Routes.OTP,
        page: () => PinCodeVerificationScreen(Get.arguments['email']),
        children: []),
  ];
}
