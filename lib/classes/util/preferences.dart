import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Pref<T> {
  locale('English'),
  calendarView('Week');

  final T initial;
  const Pref(this.initial);

  T get value => Preferences.get(this);
  Future set(T val) => Preferences.set(this, val);

  @override toString() => name;
}

class Preferences extends ChangeNotifier {
  static final Preferences instance = Preferences.internal();
  static late SharedPreferences prefs;
  factory Preferences() => instance;

  Preferences.internal();

  static void notify() => instance.notifyListeners();

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static dynamic get(Pref pref) {
    var val = prefs.get('$pref');
    if (val is List) return prefs.getStringList('$pref');
    return val ?? pref.initial;
  }

  static Future set(Pref pref, var value) async {
    if (pref.initial is int) {
      await prefs.setInt('$pref', value);
    } else if (pref.initial is bool) {
      await prefs.setBool('$pref', value);
    } else if (pref.initial is String) {
      await prefs.setString('$pref', value);
    } else if (pref.initial is List<String>) {
      await prefs.setStringList('$pref', value);
    }
    notify();
    return value;
  }
}
