import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/dependancy/injection.dart';
import 'package:store_pos/core/route/app_route.dart';
import 'package:store_pos/core/service/db_service.dart';
import 'package:store_pos/localication/translate.dart';
import 'package:store_pos/screen/main/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DbService.instance.database;
  runApp(const MyApp());
}

final _navKey = GlobalKey<NavigatorState>();

final _scaffoldMessageKey = GlobalKey<ScaffoldMessengerState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: appRoute,
      initialBinding: Injection(),
      navigatorKey: _navKey,
      scaffoldMessengerKey: _scaffoldMessageKey,
      translations: Translate(),
      defaultTransition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 150),
      locale: const Locale('km', 'KH'),
      fallbackLocale: const Locale('en', 'US'),
      initialRoute: MainScreen.routeName,
    );
  }
}
