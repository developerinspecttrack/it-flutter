import 'package:flutter/material.dart';
import 'package:client/app/theme/app_typography.dart';
import 'package:client/app/types/enums.dart';

class UserTypeQueryWidget extends StatelessWidget {
  final String selectedUserType;
  final Function(String) onUserTypeSelected;

  const UserTypeQueryWidget({
    Key? key,
    required this.selectedUserType,
    required this.onUserTypeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Select your Profession",
          style: TextStyle(
            fontFamily: AppTypography.defaultFontFamily,
            fontSize: 24,
            color: Color(0xff151515),
            letterSpacing: AppTypography().applyLetterSpacing(24, -2),
            fontWeight: FontWeight.w700,
          ),
        ),
        Text(
          "Choose your profession so that we can assist you effectively.",
          style: TextStyle(
            fontFamily: AppTypography.defaultFontFamily,
            fontSize: 16,
            height: 1.2,
            letterSpacing: AppTypography().applyLetterSpacing(16, -1),
            color: Colors.grey[700],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 24),
        Column(
          children: UserRole.roles
              .map((type) => GestureDetector(
                    onTap: () {
                      onUserTypeSelected(type.toString().split('.').last);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(13),
                          color: Colors.white,
                          border: Border(
                              top: BorderSide(
                                  color: selectedUserType ==
                                          type.toString().split('.').last
                                      ? Color.fromARGB(255, 148, 148, 148)
                                      : const Color.fromARGB(
                                          255, 205, 204, 204),
                                  width: 1),
                              bottom: BorderSide(
                                  color: selectedUserType ==
                                          type.toString().split('.').last
                                      ? Color.fromARGB(255, 148, 148, 148)
                                      : const Color.fromARGB(
                                          255, 205, 204, 204),
                                  width:
                                      selectedUserType == type.toString().split('.').last
                                          ? 4
                                          : 3),
                              left: BorderSide(
                                  color: selectedUserType ==
                                          type.toString().split('.').last
                                      ? Color.fromARGB(255, 148, 148, 148)
                                      : const Color.fromARGB(255, 205, 204, 204),
                                  width: 1),
                              right: BorderSide(color: selectedUserType == type.toString().split('.').last ? Color.fromARGB(255, 148, 148, 148) : const Color.fromARGB(255, 205, 204, 204), width: 1)),
                        ),
                        child: Center(
                          child: Text(
                            type.toString().split('.').last,
                            style: TextStyle(
                                fontFamily: AppTypography.defaultFontFamily,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                letterSpacing:
                                    AppTypography().applyLetterSpacing(16, -1),
                                color: Color.fromARGB(255, 96, 96, 97)),
                          ),
                        ),
                      ),
                    ),
                  ))
              .toList(),
        )
      ],
    );
  }
}
