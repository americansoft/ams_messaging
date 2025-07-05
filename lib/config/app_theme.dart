import 'package:ams_messaging/config/constansts/app_colors.dart';
import 'package:ams_messaging/config/constansts/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';


/// Reference to the application theme.
class AppTheme {
  static const accentColor = AppColors.accent;
  static final visualDensity = VisualDensity.adaptivePlatformDensity;

  final darkBase = ThemeData.dark();
  final lightBase = ThemeData.light();


  /// Light theme and its settings.
  ThemeData get light => ThemeData(
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.kPrimaryLightColor,
      iconColor: AppColors.kPrimaryColor,
      prefixIconColor: AppColors.kPrimaryColor,
      contentPadding: EdgeInsets.symmetric(
          horizontal: AppConstants.defaultPadding, vertical: AppConstants.defaultPadding),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        borderSide: BorderSide.none,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: Colors.white,
        backgroundColor: AppColors.kPrimaryColor,
        shape: const StadiumBorder(),
        maximumSize: const Size(double.infinity, 56),
        minimumSize: const Size(double.infinity, 56),
      ),
    ),
    brightness: Brightness.light,
    visualDensity: visualDensity,
    textTheme:
    GoogleFonts.mulishTextTheme().apply(bodyColor: AppColors.textDark),
    appBarTheme: lightBase.appBarTheme.copyWith(
      iconTheme: lightBase.iconTheme,
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 17,
        color: AppColors.textDark,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    scaffoldBackgroundColor: LightColors.background,
    cardColor: LightColors.card,
    primaryTextTheme: const TextTheme(
      titleLarge: TextStyle(color: AppColors.textDark),
    ),
    iconTheme: const IconThemeData(color: AppColors.iconDark), colorScheme: lightBase.colorScheme.copyWith(secondary: accentColor).copyWith(surface: LightColors.background),
  );

  /// Dark theme and its settings.
  ThemeData get dark => ThemeData(
    brightness: Brightness.dark,
    visualDensity: visualDensity,
    textTheme:
    GoogleFonts.interTextTheme().apply(bodyColor: AppColors.textLight),
    appBarTheme: darkBase.appBarTheme.copyWith(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 17,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    scaffoldBackgroundColor: DarkColors.background,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(backgroundColor: AppColors.secondary),
    ),
    cardColor: DarkColors.card,
    primaryTextTheme: const TextTheme(
      titleLarge: TextStyle(color: AppColors.textLight),
    ),
    iconTheme: const IconThemeData(color: AppColors.iconLight), colorScheme: darkBase.colorScheme.copyWith(secondary: accentColor).copyWith(surface: DarkColors.background),
  );
}
