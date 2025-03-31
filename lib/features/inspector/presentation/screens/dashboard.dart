import 'package:client/app/theme/app_colors.dart';
import 'package:client/app/theme/app_typography.dart';
import 'package:client/common_widgets/bottom_navigationbar.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      bottomNavigationBar: Theme(
        data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        child: BottomNavBar(currentIndex: 1),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Text(
              "Dashboard Screen",
              style: TextStyle(
                  fontFamily: AppTypography.defaultFontFamily, fontSize: 18),
            ),
          ],
        ),
      )),
    );
  }
}
