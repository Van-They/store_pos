import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('empty'.tr),
    );
  }
}
