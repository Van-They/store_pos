import 'package:get/get.dart';
import 'package:store_pos/screen/main_screen.dart';

List<GetPage<dynamic>> appRoute = [
  GetPage(
    name: '/main',
    page: () => const MainScreen(),
    transition: Transition.zoom,
  ),
];
