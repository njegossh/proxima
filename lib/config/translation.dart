import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;

class TranslationService extends ChangeNotifier {
  TranslationService._internal();
  static final TranslationService instance = TranslationService._internal();

  String _currentLocale = 'en';
  Map<String, String> _localizedValues = {};

  String get currentLocale => _currentLocale;

  Future<void> load(String locale) async {
    _currentLocale = locale;
    final jsonString =
        await rootBundle.loadString('assets/translations/$locale.json');
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    _localizedValues =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));
    notifyListeners();
  }

  String translate(String key) {
    return _localizedValues[key] ?? key;
  }
}
