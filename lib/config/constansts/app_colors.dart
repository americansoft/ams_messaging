import 'package:flutter/material.dart';



/// Global color constants (if not using full ThemeData override)
class AppColors {
  static const Color primary = Colors.deepPurple;
  static const Color background = Colors.white;
  static const Color textDark = Color(0xFF53585A);

  static const Color textMuted = Colors.black54;
  static const Color chatBubbleMe = Color(0xFFE8DFF9);
  static const Color chatBubbleOther = Color(0xFFF1F1F1);
  static const Color unreadDot = Colors.green;

  static const Color kPrimaryColor = Color(0xFF6F35A5);
  static const Color kPrimaryLightColor = Color(0xFFF1E6FF);

  static const secondary = Color(0xFF3B76F6);
  static const accent = Color(0xFFD6755B);
  static const textLight = Color(0xFFF5F5F5);
  static const textFaded = Color(0xFF9899A5);
  static const iconLight = Color(0xFFB1B4C0);
  static const iconDark = Color(0xFFB1B3C1);
  static const textHighlight = secondary;
  static const cardLight = Color(0xFFF9FAFE);
  static const cardDark = Color(0xFF303334);
}


abstract class LightColors {
  static const background = Colors.white;
  static const card = AppColors.cardLight;
}

abstract class DarkColors {
  static const background = Color(0xFF1B1E1F);
  static const card = AppColors.cardDark;
}