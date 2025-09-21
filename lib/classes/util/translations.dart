import 'dart:convert';
import 'package:flutter/services.dart';

class Translations {
  static final Translations _instance = Translations._internal();
  factory Translations() => _instance;

  Translations._internal();

  Map<String, dynamic> _localizedStrings = {};
  String currentLocale = 'sr'; // default

  Future<void> load(String locale) async {
    currentLocale = locale;
    final String jsonString =
        await rootBundle.loadString('assets/translations/$locale.json');
    _localizedStrings = json.decode(jsonString);
  }

  String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}