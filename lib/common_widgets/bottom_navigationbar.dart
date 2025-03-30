import 'package:client/app/routes/app_router.dart';
import 'package:client/app/routes/route_names.dart';
import 'package:client/app/theme/app_colors.dart';
import 'package:client/app/theme/app_typography.dart';
import 'package:client/features/dashboard/screens/dashboard.dart';
import 'package:client/features/home/presentation/screens/home.dart';
import 'package:client/features/profile/screens/profile.dart';
import 'package:client/features/scheduled/screens/schedules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final VoidCallback? onCreatePressed;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    this.onCreatePressed,
  });

  static final List<String> routes = [
    RouteNames.home,
    RouteNames.dashboard,
    RouteNames.scheduleAInspection,
    RouteNames.profile
  ];

  void _onItemTapped(BuildContext context, int index) {
    final String selectedRoute = routes[index];
    final String? currentRoute = ModalRoute.of(context)?.settings.name;

    if (currentRoute == selectedRoute) return;

    Navigator.of(context).pushReplacement(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          _getPage(selectedRoute),
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ));
  }

  Widget _getPage(String route) {
    switch (route) {
      case RouteNames.home:
        return const HomeScreen();
      case RouteNames.profile:
        return const ProfileScreen();
      case RouteNames.dashboard:
        return const DashboardScreen();
      case RouteNames.scheduleAInspection:
        return const ScheduleInspectionsScreen();
      default:
        return const ScheduleInspectionsScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D676514),
                blurRadius: 24,
                spreadRadius: 0,
                offset: Offset(0, -4),
              ),
            ],
            borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 6, bottom: 22),
            child: MouseRegion(
              cursor: SystemMouseCursors.basic,
              child: BottomNavigationBar(
                elevation: 0,
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.transparent,
                selectedFontSize: 13,
                unselectedFontSize: 13,
                selectedItemColor: Colors.black,
                unselectedItemColor: Colors.grey[600],
                selectedLabelStyle: TextStyle(
                  fontFamily: AppTypography.defaultFontFamily,
                  height: AppTypography.defaultLineHeight,
                  letterSpacing: AppTypography().applyLetterSpacing(13, 0),
                  fontWeight: FontWeight.normal,
                ),
                unselectedLabelStyle: TextStyle(
                  fontFamily: AppTypography.defaultFontFamily,
                  height: AppTypography.defaultLineHeight,
                  letterSpacing: AppTypography().applyLetterSpacing(13, 0),
                ),
                enableFeedback: false,
                showUnselectedLabels: true,
                currentIndex: currentIndex,
                onTap: (index) => _onItemTapped(context, index),
                items: [
                  _buildNavItem(
                      'assets/icons/home.svg', 'Home', currentIndex == 0),
                  _buildNavItem('assets/icons/dashboard.svg', 'Dashboard',
                      currentIndex == 1),
                  _buildNavItem('assets/icons/inspection.svg', 'Schedule',
                      currentIndex == 2),
                  _buildNavItem(
                      'assets/icons/user.svg', 'Profile', currentIndex == 3),
                ],
              ),
            ),
          ),
        ),

        // Centered purple circle button
        Positioned(
          bottom: 25, // Adjust this value to position the button vertically
          child: GestureDetector(
            onTap: onCreatePressed ??
                () {
                  // Default action if no callback is provided
                  print('Create button pressed');
                },
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primaryColor.withOpacity(0.3),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
        ),
      ],
    );
  }

  BottomNavigationBarItem _buildNavItem(
      String iconPath, String label, bool isSelected) {
    return BottomNavigationBarItem(
      icon: Stack(
        alignment: Alignment.center,
        children: [
          SvgPicture.asset(
            iconPath,
            height: 22,
            width: 22,
            colorFilter: ColorFilter.mode(
              isSelected ? Colors.black : Colors.grey[600]!,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
      label: label
          .replaceAll("/", "")
          .replaceFirstMapped(RegExp(r'^\w'), (m) => m.group(0)!.toUpperCase()),
    );
  }
}
