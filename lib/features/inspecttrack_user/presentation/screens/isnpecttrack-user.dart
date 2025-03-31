import 'package:client/app/routes/route_names.dart';
import 'package:client/app/theme/app_colors.dart';
import 'package:client/app/theme/app_typography.dart';
import 'package:client/app/types/enums.dart';
import 'package:client/common_widgets/button.dart';
import 'package:client/core/services/network/api_services.dart';
import 'package:client/features/inspecttrack_user/presentation/widgets/userdemographics_query_widget.dart';
import 'package:client/features/inspecttrack_user/presentation/widgets/usertype_query_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InspectTrackUserScreen extends StatefulWidget {
  const InspectTrackUserScreen({super.key});

  @override
  State<InspectTrackUserScreen> createState() => _InspectTrackUserScreenState();
}

class _InspectTrackUserScreenState extends State<InspectTrackUserScreen> {
  late String _selectUserType;
  late int _step = 1;

  late String _fullname;
  late String _contactNumber;
  late String _department;
  late String _userState;

  @override
  void initState() {
    super.initState();
    _selectUserType = "";
    _fullname = "";
    _contactNumber = "";
    _department = "";
    _userState = "";
  }

  void onUserTypeSelected(String userType) {
    setState(() {
      _selectUserType = userType;
    });
  }

  bool isFormValid() {
    return !_selectUserType.isEmpty &&
        !_fullname.isEmpty &&
        !_contactNumber.isEmpty &&
        !_department.isEmpty &&
        !_userState.isEmpty;
  }

  void onUserDemographicsSelected(UserDemographics userDemographics) {
    setState(() {
      _fullname = userDemographics.name!;
      _contactNumber = userDemographics.contactNumber!;
      _department = userDemographics.department!;
      _userState = userDemographics.state!;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(
        "fullname: $_fullname, contactNumber: $_contactNumber, department: $_department, userState: $_userState");
    print('user roles ${UserRole.roles}');
    return Scaffold(
      backgroundColor: AppColors.appBackgroundColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Button(
          textStyle: TextStyle(
            fontFamily: AppTypography.defaultFontFamily,
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          text: _step == 1 ? "Next" : "Submit",
          onTap: () async {
            if (_step == 1) {
              await ApiServices().setUserRole(_selectUserType);
              setState(() {
                _step += 1;
              });
            } else {
              if (isFormValid()) {
                ApiServices().setUserProfile(
                    name: _fullname,
                    contactNumner: _contactNumber,
                    department: _department,
                    state: _userState);
                Navigator.pushNamed(context, RouteNames.home);
              }
            }
          },
          backgroundColor: (_step == 1 && _selectUserType.isEmpty) ||
                  (_step == 2 && !isFormValid())
              ? AppColors.primaryColor.withOpacity(0.2)
              : AppColors.primaryColor,
          isDisabled: (_step == 1 && _selectUserType.isEmpty) ||
              (_step == 2 && !isFormValid()),
          textColor: AppColors.primaryColor,
          loadingText: "Saving...",
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Text(
                //   "Profile Information",
                //   style: TextStyle(
                //     fontFamily: AppTypography.defaultFontFamily,
                //     fontSize: 24,
                //     color: Color(0xff151515),
                //     letterSpacing: AppTypography().applyLetterSpacing(24, -2),
                //     fontWeight: FontWeight.w700,
                //   ),
                // ),
                // Text(
                //   "Ensure all the data you provide is accurate and up-to-date.",
                //   style: TextStyle(
                //     fontFamily: AppTypography.defaultFontFamily,
                //     fontSize: 16,
                //     height: 1.2,
                //     letterSpacing: AppTypography().applyLetterSpacing(16, -1),
                //     color: Colors.grey[700],
                //     fontWeight: FontWeight.w500,
                //   ),
                // ),
                // const SizedBox(height: 24),
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _step == 2
                            ? GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _step = 1;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(7),
                                        border: Border(
                                            top: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 185, 184, 184),
                                                width: 1.5),
                                            bottom: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 185, 184, 184),
                                                width: 1.5),
                                            left: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 185, 184, 184),
                                                width: 1.5),
                                            right: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 185, 184, 184),
                                                width: 1.5))),
                                    padding: EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                                    child: SvgPicture.asset('assets/icons/back.svg')),
                              )
                            : SizedBox(),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: [
                            Text(
                              "Step :",
                              style: TextStyle(
                                fontFamily: AppTypography.defaultFontFamily,
                                fontSize: 16,
                                height: 1.2,
                                letterSpacing:
                                    AppTypography().applyLetterSpacing(16, -1),
                                color: Color(0xff151515),
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Text(
                              "${_step} / 2",
                              style: TextStyle(
                                fontFamily: AppTypography.defaultFontFamily,
                                fontSize: 16,
                                height: 1.2,
                                letterSpacing:
                                    AppTypography().applyLetterSpacing(16, -1),
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 16),

                _step == 1
                    ? UserTypeQueryWidget(
                        selectedUserType: _selectUserType,
                        onUserTypeSelected: onUserTypeSelected)
                    : UserDemographicsQueryWidget(
                        onUserDemographicsSelected: onUserDemographicsSelected)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
