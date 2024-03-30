import 'package:flutter/material.dart';
import 'package:store_pos/localication/app_localize.dart';

class AppStringResource {
  static late AppLocalize appLocalize;

  static AppStringResource of(BuildContext context) {
    appLocalize = AppLocalize.of(context);
    return AppStringResource();
  }

  static String greeting(String key) {
    return appLocalize.getStringByKey(key);
  }
}

String res(String key) => AppStringResource.greeting(key);
