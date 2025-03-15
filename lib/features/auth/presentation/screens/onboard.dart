import 'package:client/app/routes/route_names.dart';
import 'package:client/app/theme/app_colors.dart';
import 'package:client/app/theme/app_typography.dart';
import 'package:client/common_widgets/button.dart';
import 'package:flutter/material.dart';

class OnboardScreen extends StatelessWidget {
  const OnboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Inspect Track",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontFamily: AppTypography.defaultFontFamily,
                          fontSize: 32,
                          letterSpacing:
                              AppTypography().applyLetterSpacing(32, -1),
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
                ),
              ),
              Button(
                  text: "Get Started",
                  lightGradient: Color(0xffFFF6C5),
                  darkGradient: Color(0xffF4CF06),
                  onTap: () =>
                      {Navigator.pushNamed(context, RouteNames.enterEmail)},
                  backgroundColor: AppColors.primaryColor)
            ],
          ),
        ),
      ),
    );
  }
}
