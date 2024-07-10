import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/data/data_source/api.dart';
import 'package:store_pos/core/data/data_source/api_client.dart';
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
      future: Future(
        () async {
          await Get.putAsync<Api>(() async {
            final api = ApiClient();
            await api.getDatabase();
            return api;
          }, permanent: true);
        },
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
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
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: appRoute,
          initialBinding: Injection(),
          navigatorKey: _navKey,
          scaffoldMessengerKey: scaffoldMessageKey,
          translations: Translate(),
          defaultTransition: Transition.rightToLeft,
          transitionDuration: const Duration(milliseconds: 150),
          locale: const Locale('km', 'KH'),
          fallbackLocale: const Locale('en', 'US'),
          initialRoute: MainScreen.routeName,
          themeMode: ThemeMode.light,
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: kBgColor,
            dialogBackgroundColor: kWhite,
            buttonTheme: const ButtonThemeData(splashColor: kPrimaryColor),
            appBarTheme: const AppBarTheme(backgroundColor: kBgColor),
          ),
        );
      },
    ),
  );
}

final _navKey = GlobalKey<NavigatorState>();

final scaffoldMessageKey = GlobalKey<ScaffoldMessengerState>();
