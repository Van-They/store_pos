import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:store_pos/localication/app_localize.dart';

class AppLocalizeDelegate extends LocalizationsDelegate<AppLocalize> {
  @override
  bool isSupported(Locale locale) {
    return AppLocalize.supportLanguage().contains(locale.languageCode);
  }

  @override
  Future<AppLocalize> load(Locale locale) {
    return SynchronousFuture<AppLocalize>(AppLocalize(locale));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalize> old) => false;
}
