import 'package:flutter/material.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/widget/text_widget.dart';

class PrimaryBtnWidget extends StatelessWidget {
  const PrimaryBtnWidget({
    super.key,
    this.label = 'button',
    this.onTap,
    this.padding,
  });

  final String label;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(appSpace.scale),
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: Colors.blueAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              appSpace.scale,
            ),
          ),
          minimumSize: Size(
            double.infinity,
            40.scale,
          ),
        ),
        onPressed: onTap ?? () {},
        child: TextWidget(text: label),
      ),
    );
  }
}
