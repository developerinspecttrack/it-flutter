class AppTypography {
  static const double defaultLineHeight = 1.26;
  static const String defaultFontFamily = 'Satoshi Variable';
  static const double defaultLetterSpacing = -2;

  double applyLetterSpacing(double fontSize, double letterSpacing) {
    return fontSize * (letterSpacing / 100);
  }
}
