import 'package:client/app/routes/route_names.dart';
import 'package:client/features/auth/presentation/screens/enter_email.dart';
import 'package:client/features/auth/presentation/screens/onboard.dart';
import 'package:client/features/auth/presentation/screens/verify_otp.dart';
import 'package:client/features/home/presentation/screens/home.dart';
import 'package:flutter/material.dart';

class AppRouter {
  static String get initialRoute => RouteNames.onboard;
  static Map<String, Widget Function(BuildContext)> get routes => {
        RouteNames.home: (context) => HomeScreen(),
        RouteNames.onboard: (context) => OnboardScreen(),
        RouteNames.enterEmail: (context) => EnterEmailScreen(),
        RouteNames.verifyEmail: (context) => OtpVerificatonScreen(),
      };
}
