import 'package:flutter/material.dart';
import 'package:store_pos/core/constant/colors.dart';

class RefreshIndicatorWidget extends StatelessWidget {
  const RefreshIndicatorWidget({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  final Widget child;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: kPrimaryColor,
      onRefresh: () async => onRefresh(),
      child: child,
    );
  }
}
