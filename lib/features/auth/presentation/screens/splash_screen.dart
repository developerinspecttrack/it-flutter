import 'package:client/app/routes/route_names.dart';
import 'package:client/app/theme/app_colors.dart';
import 'package:client/app/theme/app_typography.dart';
import 'package:client/core/services/user/storage.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void checkAuth() async {
    print("Checking auth status...");
    bool isLoggedIn = await UserService.isUserLoggedIn();
    print("User logged in: $isLoggedIn");

    if (isLoggedIn) {
      if (await UserService.getProfileStatus()) {
        await Future.delayed(const Duration(seconds: 2)).then((_) {
          print("Navigating to home screen");
          Navigator.pushReplacementNamed(context, RouteNames.home);
        });
      } else {
        await Future.delayed(const Duration(seconds: 2)).then((_) {
          print("Navigating to home screen");
          Navigator.pushReplacementNamed(context, RouteNames.ituserInfo);
        });
      }
    } else {
      await Future.delayed(const Duration(seconds: 2)).then((_) {
        print("Navigating to onboard screen");
        Navigator.pushReplacementNamed(context, RouteNames.onboard);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    checkAuth();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Inspect Track",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.primaryColor,
                    fontFamily: AppTypography.defaultFontFamily,
                    fontSize: 32,
                    letterSpacing: AppTypography().applyLetterSpacing(32, -1),
                    height: 1.23,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "A field visit tracking app for Indian officials",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xff736F88),
                    fontFamily: AppTypography.defaultFontFamily,
                  ),
                ),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
