import 'package:flutter/material.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/widget/text_widget.dart';

class PrimaryBtnWidget extends StatelessWidget {
  const PrimaryBtnWidget({
    super.key,
    this.label = 'button',
    this.onTap,
    this.padding,
    this.size,
    this.color = kPrimaryColor,
    this.width=double.infinity,
    this.height,
  });

  final String label;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final Size? size;
  final double width;
  final double? height;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(appSpace.scale),
      child: FilledButton(
        style: FilledButton.styleFrom(
          backgroundColor: color,
          elevation: 0.0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              appSpace.scale,
            ),
          ),
          minimumSize: size ?? Size(
            width,
            height ?? 40.scale,
          ),
        ),
        onPressed: onTap ?? () {},
        child: TextWidget(text: label),
      ),
    );
  }
}
