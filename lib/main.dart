import 'package:flutter/material.dart';
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
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        }
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
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
          themeMode: ThemeMode.light,
          theme: ThemeData(
            scaffoldBackgroundColor: kWhite,
            appBarTheme: const AppBarTheme(backgroundColor: kWhite),
          ),
        );
      },
    ),
  );
}

final _navKey = GlobalKey<NavigatorState>();

final _scaffoldMessageKey = GlobalKey<ScaffoldMessengerState>();
