import 'dart:ui';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppConstants {
  static String BASE_URL = dotenv.get("BASE_URL");
  static String APP_NAME = dotenv.get("APP_NAME");
  static String LANGUAGE_KEY = "languagekey";
  static String FCM_TOKEN = "fcmToken";
  static String IS_DARK_THEME = "isDarkTheme";
  static String ACCESS_TOKEN = "accessToken";
  static String REFRESH_TOKEN = "refreshToken";
  static String DEFULT_LANGUAGE_CODE = "en";
  static String BIOMETRICE_ACTIVE = "biometricActive";
  static String BIOMETRICE_AVAILABLE = "biometricAvailable";
  static String VALIDATION_STATE_KEY = "validation_state";
  static List<Locale> SUPPORTTED_LOCALES = [
    const Locale('en'),
    const Locale('ar'),
  ];
}
