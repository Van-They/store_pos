import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/dependancy/injection.dart';
import 'package:store_pos/core/route/app_route.dart';
import 'package:store_pos/localication/translate.dart';
import 'package:store_pos/screen/main/main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    FutureBuilder(
      future: DInjection.initDatabase(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoading();
        }
        return _buildScreen();
      },
    ),
  );
}

GetMaterialApp _buildScreen() {
  return GetMaterialApp(
    debugShowCheckedModeBanner: false,
    getPages: appRoute,
    initialBinding: DInjection(),
    navigatorKey: _navKey,
    scaffoldMessengerKey: scaffoldMessageKey,
    translations: Translate(),
    defaultTransition: Transition.rightToLeft,
    locale: const Locale('km', 'KH'),
    fallbackLocale: const Locale('en', 'US'),
    initialRoute: MainScreen.routeName,
    themeMode: ThemeMode.light,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: kBgColor,
      dialogBackgroundColor: kWhite,
      buttonTheme: const ButtonThemeData(splashColor: kWhite),
      radioTheme: const RadioThemeData(
        fillColor: MaterialStatePropertyAll(kPrimaryColor),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: kWhite,
        titleTextStyle: TextStyle(color: kBlack),
      ),
    ),
  );
}

Widget _buildLoading() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Container(
      color: kWhite,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation(kPrimaryColor),
      ),
    ),
  );
}

final _navKey = GlobalKey<NavigatorState>();

final scaffoldMessageKey = GlobalKey<ScaffoldMessengerState>();
