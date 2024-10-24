import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:store_pos/widget/text_widget.dart';

class CustomEmptyWidget extends StatelessWidget {
  const CustomEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: TextWidget(text: 'no_records'.tr),
    );
  }
}
