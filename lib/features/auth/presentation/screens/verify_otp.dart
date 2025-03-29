import 'package:client/app/routes/route_names.dart';
import 'package:client/app/theme/app_colors.dart';
import 'package:client/app/theme/app_typography.dart';
import 'package:client/common_widgets/button.dart';
import 'package:client/core/services/network/api_services.dart';
import 'package:client/core/services/user/storage.dart';
import 'package:client/features/auth/models/arguments.model.dart';
import 'package:client/features/auth/models/params.model.dart';
import 'package:client/features/home/presentation/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:geolocator/geolocator.dart';

class OtpVerificatonScreen extends StatefulWidget {
  const OtpVerificatonScreen({super.key});

  @override
  State<OtpVerificatonScreen> createState() => _OtpVerificatonScreenState();
}

class _OtpVerificatonScreenState extends State<OtpVerificatonScreen> {
  late double _lat;
  late double _long;
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {
    try {
      // First check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        print('Location services are disabled');
        return;
      }

      // Check location permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        // Request permission
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permission still denied
          print('Location permissions are denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        // Permissions are permanently denied
        print('Location permissions are permanently denied');
        return;
      }

      // Now that we have permission, get the position
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);

      setState(() {
        _lat = position.latitude;
        _long = position.longitude;
      });

      print('Location retrieved: ${position.latitude}, ${position.longitude}');
    } catch (e) {
      print('Error getting location: $e');
    }
  }

  String _otpCode = '';
  bool _isLoading = false;

  Future<void> verifyOtp() async {
    if (_otpCode.length != 4) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a complete 4-digit OTP')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    print('triggered verify otp');
    final response = await ApiServices().verifyOtp(_otpCode, _lat, _long);
    print('verify otp response: $response');
    final userToken = await UserService.getUserAccessToken();

    if (userToken != null && await UserService.isUserLoggedIn()) {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

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
                height: 24,
              ),
              Text(
                "Enter 4 Digit OTP",
                style: TextStyle(
                  fontSize: 24,
                  color: const Color.fromARGB(255, 61, 60, 60),
                  height: 1.24,
                  fontWeight: FontWeight.w700,
                  fontFamily: AppTypography.defaultFontFamily,
                  letterSpacing: AppTypography().applyLetterSpacing(24, -2),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                "An OTP has been sent to ${args.email} ",
                style: TextStyle(
                  fontSize: 14,
                  color: const Color.fromARGB(255, 92, 89, 106),
                  height: 1.24,
                  fontWeight: FontWeight.w500,
                  fontFamily: AppTypography.defaultFontFamily,
                  letterSpacing: AppTypography().applyLetterSpacing(14, 0),
                ),
              ),
              SizedBox(
                height: 31,
              ),
              OtpTextField(
                numberOfFields: 4,
                textStyle: TextStyle(
                    fontFamily: AppTypography.defaultFontFamily,
                    fontWeight: FontWeight.w500),
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
                onCodeChanged: (String code) {
                  _otpCode = code;
                },
                onSubmit: (String verificationCode) {
                  _otpCode = verificationCode;
                },
              ),
              const SizedBox(
                height: 24,
              ),
              const Spacer(),
              Button(
                text: "Verify OTP",
                loadingText: "Verifying OTP",
                lightGradient: Color.fromARGB(255, 91, 137, 244),
                darkGradient: Color.fromARGB(255, 0, 74, 247),
                onTap: verifyOtp,
                isLoading: _isLoading,
                backgroundColor: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
