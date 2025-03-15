import 'package:client/app/routes/route_names.dart';
import 'package:client/app/theme/app_colors.dart';
import 'package:client/app/theme/app_typography.dart';
import 'package:client/common_widgets/button.dart';
import 'package:client/core/services/network/api_services.dart';
import 'package:client/core/services/user/storage.dart';
import 'package:client/features/auth/models/params.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpVerificatonScreen extends StatefulWidget {
  const OtpVerificatonScreen({super.key});

  @override
  State<OtpVerificatonScreen> createState() => _OtpVerificatonScreenState();
}

class _OtpVerificatonScreenState extends State<OtpVerificatonScreen> {
  void verifyOtp(String otp) {}
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments as UserEmail;
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
              "Enter 4 Digit OTP",
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
              "An OTP has been sent to ${args.email} ",
              style: TextStyle(
                  fontSize: 14,
                  color: const Color(0xff736F88),
                  height: 1.24,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppTypography.defaultFontFamily,
                  letterSpacing: AppTypography().applyLetterSpacing(14, 0)),
            ),
            SizedBox(
              height: 31,
            ),
            OtpTextField(
              numberOfFields: 4,
              fieldHeight: 70,
              fieldWidth: 70,
              borderRadius: BorderRadius.circular(12),
              enabledBorderColor: AppColors.primaryColor,
              disabledBorderColor: AppColors.primaryColor,
              focusedBorderColor: AppColors.primaryColor,
              borderWidth: 1,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              borderColor: AppColors.primaryColor,
              showFieldAsBox: true,
              onCodeChanged: (String code) {},
              onSubmit: (String verificationCode) async {
                final response =
                    await ApiServices().verifyOtp(verificationCode);
                final userToken = await UserService.getUserToken();

                if (userToken != null) {
                  Navigator.pushNamed(context, RouteNames.home);
                }
              },
            ),
            const SizedBox(
              height: 50,
            ),
            const Spacer(),
            Button(
                text: "Verify OTP",
                lightGradient: const Color(0xffFFF6C5),
                darkGradient: const Color(0xffF4CF06),
                onTap: () => verifyOtp("5342"),
                backgroundColor: AppColors.primaryColor),
          ],
        ),
      )),
    );
  }
}
