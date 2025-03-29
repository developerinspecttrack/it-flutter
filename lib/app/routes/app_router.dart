import 'package:client/app/routes/route_names.dart';
import 'package:client/core/services/user/storage.dart';
import 'package:client/features/auth/presentation/screens/enter_email.dart';
import 'package:client/features/auth/presentation/screens/onboard.dart';
import 'package:client/features/auth/presentation/screens/splash_screen.dart';
import 'package:client/features/auth/presentation/screens/verify_otp.dart';
import 'package:client/features/home/presentation/screens/home.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Future<bool> initializeToken() async {
    userToken = await UserService.getUserAccessToken();
    if (userToken != null) {
      return true;
    }
    return false;
  }

  static String get initialRoute => RouteNames.onboard;

  late String? userToken;

  static Map<String, Widget Function(BuildContext)> get routes => {
        RouteNames.initialScreen: (context) => SplashScreen(),
        RouteNames.home: (context) => HomeScreen(),
        RouteNames.onboard: (context) => OnboardScreen(),
        RouteNames.enterEmail: (context) => EnterEmailScreen(),
        RouteNames.verifyEmail: (context) => OtpVerificatonScreen(),
      };
}
