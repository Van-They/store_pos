import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/dependancy/injection.dart';
import 'package:store_pos/core/route/app_route.dart';
import 'package:store_pos/localication/translate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: Injection(),
      getPages: appRoute,
      translations: Translate(),
      defaultTransition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150),
      locale: const Locale('km', 'KH'),
      fallbackLocale: const Locale('en', 'US'),
      initialRoute: '/main',
    );
  }
}
