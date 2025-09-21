import 'package:flutter/material.dart';

class SettingsController {
  // Currently selected language (for UI only)
  String selectedLanguage = 'en';

  // List of languages with names and flag emojis
  final Map<String, Map<String, String>> languages = {
    'ar': {'name': 'Arabic', 'flag': '🇸🇦'},
    'ch': {'name': 'Chinese', 'flag': '🇨🇳'},
    'de': {'name': 'German', 'flag': '🇩🇪'},
    'en': {'name': 'English', 'flag': '🇬🇧'},
    'es': {'name': 'Spanish', 'flag': '🇪🇸'},
    'fi': {'name': 'Finnish', 'flag': '🇫🇮'},
    'fr': {'name': 'French', 'flag': '🇫🇷'},
    'gr': {'name': 'Greek', 'flag': '🇬🇷'},
    'it': {'name': 'Italian', 'flag': '🇮🇹'},
    'jp': {'name': 'Japanese', 'flag': '🇯🇵'},
    'ko': {'name': 'South Korean', 'flag': '🇰🇷'},
    'no': {'name': 'Norwegian', 'flag': '🇳🇴'},
    'pl': {'name': 'Polish', 'flag': '🇵🇱'},
    'pt': {'name': 'Portuguese', 'flag': '🇵🇹'},
    'ru': {'name': 'Russian', 'flag': '🇷🇺'},
    'sr': {'name': 'Serbian Latin', 'flag': '🇷🇸'},
    'src': {'name': 'Serbian Cyrillic', 'flag': '🇷🇸'},
    'sv': {'name': 'Swedish', 'flag': '🇸🇪'},
    'tr': {'name': 'Turkish', 'flag': '🇹🇷'},
    'uk': {'name': 'Ukrainian', 'flag': '🇺🇦'},
  };

  // Update the selected language (UI only)
  void selectLanguage(String code) {
    selectedLanguage = code;
  }
}
