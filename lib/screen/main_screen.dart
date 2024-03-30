import 'package:flutter/material.dart';
import 'package:store_pos/localication/app_string_resource.dart';
import 'package:store_pos/widget/app_bar_widget.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    AppStringResource.of(context);
    return Scaffold(
      appBar: AppBarWidget(title: res('hello')),
    );
  }
}
