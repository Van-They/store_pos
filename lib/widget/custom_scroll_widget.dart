import 'package:flutter/material.dart';

class CustomScrollWidget extends StatelessWidget {
  const CustomScrollWidget({super.key,this.child});
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView();
  }
}
