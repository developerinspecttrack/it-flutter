import 'package:flutter/material.dart';
import 'package:client/app/theme/app_typography.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color backgroundColor;
  final String loadingText;
  final Color textColor;
  final double height;
  final double? width;
  final double borderRadius;
  final double fontSize;
  final FontWeight fontWeight;
  final double borderWidth;
  final Color lightGradient;
  final Color darkGradient;
  final bool isLoading;

  const Button({
    Key? key,
    required this.text,
    required this.onTap,
    required this.backgroundColor,
    required this.lightGradient,
    required this.darkGradient,
    this.textColor = Colors.white,
    this.height = 50,
    this.width,
    this.borderRadius = 12,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w700,
    this.borderWidth = 2.0,
    this.isLoading = false,
    required this.loadingText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: width ?? double.infinity,
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [lightGradient, darkGradient],
          ),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Padding(
          padding: EdgeInsets.all(borderWidth),
          child: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(borderRadius - 2),
            ),
            child: Center(
              child: isLoading
                  ? Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text(
                        loadingText,
                        style: TextStyle(
                          color: textColor,
                          fontSize: fontSize,
                          fontFamily: AppTypography.defaultFontFamily,
                          fontWeight: fontWeight,
                        ),
                      ),
                      SizedBox(width: 12),
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2.5,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeCap: StrokeCap.round,
                          semanticsLabel: 'Loading...',
                        ),
                      ),
                    ])
                  : Text(
                      text,
                      style: TextStyle(
                        color: textColor,
                        fontSize: fontSize,
                        fontFamily: AppTypography.defaultFontFamily,
                        fontWeight: fontWeight,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
