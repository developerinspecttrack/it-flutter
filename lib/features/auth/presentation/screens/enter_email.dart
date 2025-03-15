import 'package:client/app/routes/route_names.dart';
import 'package:client/app/theme/app_colors.dart';
import 'package:client/app/theme/app_typography.dart';
import 'package:client/common_widgets/button.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class EnterEmailScreen extends StatefulWidget {
  const EnterEmailScreen({super.key});

  @override
  State<EnterEmailScreen> createState() => _EnterEmailScreenState();
}

class _EnterEmailScreenState extends State<EnterEmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  String? _generatedOtp;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void sendOtp() {
    final email = _emailController.text.trim();
    print("Email : ${email}");

    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid email')));
      return;
    }

    Navigator.pushNamed(
      context,
      RouteNames.home,
      arguments: {
        'email': email,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 50,
            ),
            Text(
              "Enter your Email ID",
              style: TextStyle(
                  fontSize: 24,
                  color: const Color(0xff6B6B6B),
                  height: 1.24,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppTypography.defaultFontFamily,
                  letterSpacing: AppTypography().applyLetterSpacing(24, -2)),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(
              "Enter your government registered Email ID",
              style: TextStyle(
                  fontSize: 14,
                  color: const Color(0xff736F88),
                  height: 1.24,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppTypography.defaultFontFamily,
                  letterSpacing: AppTypography().applyLetterSpacing(14, 0)),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              height: 50,
              child: TextField(
                controller: _emailController,
                style: TextStyle(
                    fontSize: 18, fontFamily: AppTypography.defaultFontFamily),
                keyboardType: TextInputType.emailAddress,
                cursorColor: AppColors.primaryColor,
                decoration: InputDecoration(
                    hintText: "example@gmail.com",
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(color: AppColors.primaryColor, width: 1),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(color: AppColors.primaryColor, width: 1),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                            color: AppColors.primaryColor, width: 1))),
              ),
            ),
            const Spacer(),
            Button(
                text: "Send OTP",
                lightGradient: const Color(0xffFFF6C5),
                darkGradient: const Color(0xffF4CF06),
                onTap: sendOtp,
                backgroundColor: AppColors.primaryColor),
          ],
        ),
      )),
    );
  }
}
