import 'package:flutter/material.dart';

/// Single source of truth for the palette used across the app.
abstract final class AppColors {
  // Home (Lab 2, page 1)
  static const primaryBlue = Color(0xFF3D5CFF);
  static const primaryDark = Color(0xFF1F1F39);
  static const accentOrange = Color(0xFFFF6B00);
  static const textGrey = Color(0xFF858597);
  static const homeBackground = Color(0xFFF8F9FB);
  static const learnCardBlue = Color(0xFFD4EBFB);
  static const meetupPurple = Color(0xFF440687);
  static const meetupBackground = Color(0xFFEDE0FC);
  static const progressTrack = Color(0xFFEAEAFF);

  // Course overview (Lab 2, page 2)
  static const overviewBackground = Color(0xFFFAFBFF);
  static const orange = Color(0xFFFF7300);
  static const orangeLocked = Color(0xFFFFE0CC);
  static const dark = Color(0xFF0B0B0D);
  static const metaGrey = Color(0xFF76777B);
  static const durationGrey = Color(0xFF9C9D9F);
  static const tabGrey = Color(0xFFC5C6C8);
  static const ratingBackground = Color(0xFFEAF3F9);
  static const star = Color(0xFFFFC62D);
}
