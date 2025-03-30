import 'package:client/app/theme/app_colors.dart';
import 'package:client/app/theme/app_typography.dart';
import 'package:client/common_widgets/bottom_navigationbar.dart';
import 'package:flutter/material.dart';

class ScheduleInspectionsScreen extends StatefulWidget {
  const ScheduleInspectionsScreen({super.key});

  @override
  State<ScheduleInspectionsScreen> createState() =>
      _ScheduleInspectionsScreenState();
}

class _ScheduleInspectionsScreenState extends State<ScheduleInspectionsScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
       backgroundColor: AppColors.appBackgroundColor,
      bottomNavigationBar: BottomNavBar(currentIndex: 2),
      body: SafeArea(
          child: Center(
        child: Column(
          children: [
            Text(
              "Schedules Screen",
              style: TextStyle(
                  fontFamily: AppTypography.defaultFontFamily, fontSize: 18),
            ),
          ],
        ),
      )),
    );
  }
}
