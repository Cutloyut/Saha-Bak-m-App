import 'dart:convert';

import 'package:flutter/services.dart';

class TranslationService {
  static Map<String, String> _localizedStrings = {};

  static Future<void> load() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/lang/tr.json',
      );
      final Map<String, dynamic> jsonMap = json.decode(jsonString);
      _localizedStrings = jsonMap.map((key, value) {
        return MapEntry(key, value.toString());
      });
    } catch (e) {
      return;
    }
  }

  static String translate(String key) {
    return _localizedStrings[key] ?? key;
  }
}

extension TranslateString on String {
  String get tr => TranslationService.translate(this);
}
