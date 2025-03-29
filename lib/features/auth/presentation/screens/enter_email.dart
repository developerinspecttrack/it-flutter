import 'package:client/app/routes/route_names.dart';
import 'package:client/app/theme/app_colors.dart';
import 'package:client/app/theme/app_typography.dart';
import 'package:client/common_widgets/button.dart';
import 'package:client/core/services/network/api_services.dart';
import 'package:client/features/auth/models/params.model.dart';
import 'package:flutter/material.dart';
import 'dart:math';

class EnterEmailScreen extends StatefulWidget {
  const EnterEmailScreen({super.key});

  @override
  State<EnterEmailScreen> createState() => _EnterEmailScreenState();
}

class _EnterEmailScreenState extends State<EnterEmailScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void sendOtp() async {
    final email = _emailController.text.trim();

    if (email.isEmpty || !email.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter a valid email')));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await ApiServices().sendotp(email);
      Navigator.pushNamed(context, RouteNames.verifyEmail,
          arguments: UserEmail(email: email));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send OTP: ${e.toString()}')));
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
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
              height: 24,
            ),
            Text(
              "Enter your Email ID",
              style: TextStyle(
                  fontSize: 24,
                  color: const Color.fromARGB(255, 61, 60, 60),
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
                  color: const Color.fromARGB(255, 92, 89, 106),
                  height: 1.24,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppTypography.defaultFontFamily,
                  letterSpacing: AppTypography().applyLetterSpacing(14, 0)),
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 50,
              child: TextField(
                controller: _emailController,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                    fontFamily: AppTypography.defaultFontFamily),
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
                loadingText: "Sending OTP",
                lightGradient: Color.fromARGB(255, 91, 137, 244),
                darkGradient: Color.fromARGB(255, 0, 74, 247),
                onTap: sendOtp,
                isLoading: _isLoading,
                backgroundColor: AppColors.primaryColor),
          ],
        ),
      )),
    );
  }
}
