import 'package:client/app/types/enums.dart';
import 'package:flutter/material.dart';
import 'package:client/app/theme/app_typography.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserDemographicsQueryWidget extends StatefulWidget {
  final Function(UserDemographics) onUserDemographicsSelected;
  const UserDemographicsQueryWidget(
      {Key? key, required this.onUserDemographicsSelected})
      : super(key: key);

  @override
  State<UserDemographicsQueryWidget> createState() =>
      _UserDemographicsQueryWidgetState();
}

class _UserDemographicsQueryWidgetState
    extends State<UserDemographicsQueryWidget> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  String? _selectedDepartment;
  String? _selectedState;
  File? _profileImage;
  final _formKey = GlobalKey<FormState>();

  final List<String> _departments = Department.departments;
  final List<String> _states = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
    'Andaman and Nicobar Islands',
    'Chandigarh',
    'Dadra and Nagar Haveli and Daman and Diu',
    'Lakshadweep',
    'Delhi',
    'Puducherry',
    'Ladakh',
    'Jammu and Kashmir'
  ];

  final Color _primaryColor = const Color.fromARGB(255, 42, 86, 243);

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Call submitForm on initial build to ensure parent has valid data
    // We use a microtask to ensure it runs after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _submitForm();
    });
  }

  void _submitForm() {
    // We don't validate here since this might be called before user input
    UserDemographics userDemographics = UserDemographics(
      name: _nameController.text,
      contactNumber: _contactController.text,
      department: _selectedDepartment ?? '',
      state: _selectedState ?? '',
    );

    // Pass the data back to the parent using the callback
    widget.onUserDemographicsSelected(userDemographics);
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Complete Your Profile",
            style: TextStyle(
              fontFamily: AppTypography.defaultFontFamily,
              fontSize: 24,
              color: const Color(0xff151515),
              letterSpacing: AppTypography().applyLetterSpacing(24, -2),
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "Please provide your details to personalize your experience.",
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

          // Name Field
          _buildTextField(
            controller: _nameController,
            label: "Name",
            onChanged: (value) => _submitForm(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your name";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Contact Number Field
          _buildTextField(
            controller: _contactController,
            label: "Contact Number",
            keyboardType: TextInputType.phone,
            onChanged: (value) => _submitForm(),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please enter your contact number";
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Department Dropdown
          _buildDropdown(
            value: _selectedDepartment,
            items: _departments,
            hint: "Select Department",
            label: "Department",
            onChanged: (value) {
              setState(() {
                _selectedDepartment = value;
                _submitForm();
              });
            },
          ),
          const SizedBox(height: 16),

          // State Dropdown
          _buildDropdown(
            value: _selectedState,
            items: _states,
            hint: "Select State",
            label: "State",
            onChanged: (value) {
              setState(() {
                _selectedState = value;
                _submitForm();
              });
            },
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
    Function(String)? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: AppTypography.defaultFontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xff151515),
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          onChanged: onChanged,
          style: TextStyle(
            fontFamily: AppTypography.defaultFontFamily,
            fontWeight: FontWeight.w500,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: "Enter your $label",
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(
                color: Colors.grey[300]!,
                width: 1,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(
                color: Colors.grey[300]!,
                width: 1,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: BorderSide(
                color: _primaryColor,
                width: 2,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: const BorderSide(
                color: Colors.red,
                width: 1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown({
    required String? value,
    required List<String> items,
    required String hint,
    required String label,
    required Function(String?) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontFamily: AppTypography.defaultFontFamily,
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xff151515),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(
              color: Colors.grey[300]!,
              width: 1,
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              hoverColor: Colors.transparent,
              applyElevationOverlayColor: false,
              focusColor: Colors.transparent,
            ),
            child: InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: DropdownButtonFormField<String>(
                iconEnabledColor: Colors.transparent,
                value: value,
                focusColor: Colors.transparent,
                enableFeedback: false,
                elevation: 0,
                icon: const Icon(Icons.arrow_drop_down),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                  border: InputBorder.none,
                ),
                hint: Text(
                  hint,
                  style: TextStyle(
                    fontFamily: AppTypography.defaultFontFamily,
                    color: Colors.grey[500],
                  ),
                ),
                items: items.map((String item) {
                  return DropdownMenuItem(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(
                        fontFamily: AppTypography.defaultFontFamily,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: onChanged,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please select a $label";
                  }
                  return null;
                },
                isExpanded: true,
                dropdownColor: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }
}
