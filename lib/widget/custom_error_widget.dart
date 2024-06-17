import 'package:flutter/widgets.dart';
import 'package:get/utils.dart';
import 'package:store_pos/widget/text_widget.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: TextWidget(text: 'something_went_wrong'.tr),
    );
  }
}
