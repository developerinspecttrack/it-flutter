import 'package:client/app/theme/app_typography.dart';
import 'package:client/core/services/user/storage.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<String?> _getUserToken() async {
    return await UserService.getUserToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: FutureBuilder<String?>(
            future: _getUserToken(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return const Text("Error loading user token");
              } else {
                final userToken = snapshot.data ?? "Guest";
                return Text(
                  "Hello $userToken",
                  style: TextStyle(fontFamily: AppTypography.defaultFontFamily),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
