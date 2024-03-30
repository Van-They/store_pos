import 'package:flutter/material.dart';

class AppLocalize {
  final Locale locale;
  const AppLocalize(this.locale);
  static AppLocalize of(BuildContext context) {
    return Localizations.of(context, AppLocalize);
  }

  static List<String> supportLanguage() {
    return stringResource.keys.toList();
  }

  String getStringByKey(String key) {
    try {
      if (stringResource[locale.languageCode]![key] == null) {
        return key; //when string not contain in resource it will return key as value
      }
      return stringResource[locale.languageCode]![key]!;
    } on Exception {
      return key;
    }
  }

  static const stringResource = <String, Map<String, String>>{
    "en": english,
    "km": khmer,
  };

  static const english = {"hello": "Hello"};
  static const khmer = {"hello": 'សួស្តី'};
}
