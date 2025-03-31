import 'package:client/app/theme/app_colors.dart';
import 'package:client/app/theme/app_typography.dart';
import 'package:client/common_widgets/bottom_navigationbar.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      bottomNavigationBar: Theme(
        data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        child: BottomNavBar(currentIndex: 3),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Text(
              "Profile Screen",
              style: TextStyle(
                  fontFamily: AppTypography.defaultFontFamily, fontSize: 18),
            ),
          ],
        ),
      )),
    );
  }
}
