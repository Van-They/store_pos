import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/route/app_route.dart';
import 'package:store_pos/localication/translate.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: appRoute,
      translations: Message(),
      locale: const Locale('km', 'KH'),
      fallbackLocale: const Locale('en', 'US'),
      initialRoute: '/main',
    );
  }
}
