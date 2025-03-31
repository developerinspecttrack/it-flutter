import 'package:client/app/theme/app_typography.dart';
import 'package:client/common_widgets/bottom_navigationbar.dart';
import 'package:client/core/services/network/api_services.dart';
import 'package:client/core/services/user/storage.dart';

import 'package:client/features/auth/models/userprofile.model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String _userAddress = '';

  void getUserAddress() async {
    String? address = await UserService.getUserAddress();
    setState(() {
      _userAddress = address!;
    });
  }

  @override
  void initState() {
    super.initState();
    getUserAddress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Theme(
        data: ThemeData(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent),
        child: BottomNavBar(currentIndex: 0),
      ),
      body: SafeArea(
        child: PopScope(
          canPop: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeAppBar(address: _userAddress),
                const SizedBox(height: 24),
                GestureDetector(
                  onTap: () async {
                    await UserService.logOutUser();
                  },
                  child: Text(
                    "Recent Inspections",
                    style: TextStyle(
                      fontSize: 18,
                      letterSpacing: AppTypography().applyLetterSpacing(18, -2),
                      fontFamily: AppTypography.defaultFontFamily,
                      fontWeight: FontWeight.w700,
                    ),
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
  final String address;

  const HomeAppBar({super.key, required this.address});

  @override
  Widget build(BuildContext context) {
    return Row(
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
            address,
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
    );
  }
}
