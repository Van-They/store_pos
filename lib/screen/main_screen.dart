import 'package:flutter/material.dart';
import 'package:store_pos/widget/app_bar_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(appBar: AppBarWidget(title: "MainScreen"),);
  }
}
