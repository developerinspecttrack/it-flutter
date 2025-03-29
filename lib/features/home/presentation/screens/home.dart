import 'package:client/app/theme/app_typography.dart';
import 'package:client/core/services/network/api_services.dart';
import 'package:client/core/services/user/storage.dart';
import 'package:client/features/auth/models/arguments.model.dart';
import 'package:client/features/auth/models/userprofile.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<UserProfile>? _profileFuture;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _profileFuture = ApiServices().getUserProfile();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: PopScope(
          canPop: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeAppBar(profileFuture: _profileFuture),
                const SizedBox(height: 24),
                Text(
                  "Recent Inspections",
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: AppTypography().applyLetterSpacing(18, -2),
                    fontFamily: AppTypography.defaultFontFamily,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 180),
                Text(
                  "Scheduled  Inspections",
                  style: TextStyle(
                    fontSize: 18,
                    letterSpacing: AppTypography().applyLetterSpacing(18, -2),
                    fontFamily: AppTypography.defaultFontFamily,
                    fontWeight: FontWeight.w700,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomeAppBar extends StatelessWidget {
  final Future<UserProfile>? profileFuture;

  const HomeAppBar({super.key, this.profileFuture});

  @override
  Widget build(BuildContext context) {
    // If the future is null, show a placeholder
    if (profileFuture == null) {
      return Container(
        height: 40,
        child: Row(
          children: [
            SvgPicture.asset(
              'assets/icons/map_pin.svg',
              color: Colors.grey,
              height: 24,
              width: 24,
            ),
            const SizedBox(width: 8),
            Text(
              "Loading location...",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
                fontFamily: AppTypography.defaultFontFamily,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    // Otherwise, use the FutureBuilder with the provided future
    return FutureBuilder<UserProfile>(
      future: profileFuture,
      builder: (context, snapshot) {
        print('Building HomeAppBar: ${snapshot.connectionState}');

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return Container(
            height: 40,
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/map_pin.svg',
                  color: Colors.grey,
                  height: 24,
                  width: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  "Location unavailable",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                    fontFamily: AppTypography.defaultFontFamily,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          );
        }

        return Container(
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/map_pin.svg',
                color: Colors.blue,
                height: 24,
                width: 24,
              ),
              const SizedBox(width: 8),
              SizedBox(
                width: 250,
                child: Text(
                  snapshot.data!.address,
                  maxLines: 2,
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: AppTypography().applyLetterSpacing(14, -1),
                    color: Color(0xff151515),
                    fontFamily: AppTypography.defaultFontFamily,
                    fontWeight: FontWeight.w500,
                  ),
                  textWidthBasis: TextWidthBasis.parent,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
