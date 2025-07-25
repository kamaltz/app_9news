// lib/src/utils/preferences_util.dart

import 'package:shared_preferences/shared_preferences.dart';

class PreferencesUtil {
  static const String _hasSeenOnboardingKey = 'has_seen_onboarding';

  // Check if user has seen onboarding
  static Future<bool> hasSeenOnboarding() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_hasSeenOnboardingKey) ?? false;
  }

  // Mark onboarding as seen
  static Future<void> markOnboardingAsSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hasSeenOnboardingKey, true);
  }
}