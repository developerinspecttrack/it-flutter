import 'package:client/app/theme/app_typography.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text("Hello", style: TextStyle(fontFamily: AppTypography.defaultFontFamily), ),
        ),
      ),
    );
  }
}
