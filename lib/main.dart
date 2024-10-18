import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/dependancy/injection.dart';
import 'package:store_pos/core/route/app_route.dart';
import 'package:store_pos/core/service/app_database.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/localication/translate.dart';
import 'package:store_pos/screen/main/main_screen.dart';
import 'package:store_pos/widget/text_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final isData = await AppDatabase.instance.init();
  logger.d(isData ? "Database created" : "Database create failed");
  final database = await AppDatabase.instance.getDatabase;

  runApp(_buildScreen(database));

  // if (isData) {
  //   runApp(_buildScreen(database));
  // } else {
  //   runApp(_buildLoading());
  // }
}

GetMaterialApp _buildScreen(Database database) {
  return GetMaterialApp(
    debugShowCheckedModeBanner: false,
    getPages: appRoute,
    initialBinding: DInjection(database),
    translations: Translate(),
    defaultTransition: Transition.rightToLeft,
    locale: const Locale('en', 'US'),
    fallbackLocale: const Locale('en', 'US'),
    initialRoute: MainScreen.routeName,
    themeMode: ThemeMode.light,
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: kBgColor,
      dialogBackgroundColor: kWhite,
      buttonTheme: const ButtonThemeData(splashColor: kWhite),
      radioTheme: const RadioThemeData(
        fillColor: WidgetStatePropertyAll(kBlack),
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
      child: const TextWidget(text: "Something went wrong"),
    ),
  );
}

