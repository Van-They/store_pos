import 'package:flutter/material.dart';
import 'package:store_pos/screen/main_screen.dart';

class AppRoute {
  static Route<dynamic>? route(RouteSettings settings) {
    switch (settings.name) {
      case "/":
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const MainScreen();
          },
        );
    }
    return null;
  }
}
