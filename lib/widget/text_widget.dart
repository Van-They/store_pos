import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_common/get_reset.dart';
import 'package:store_pos/core/constant/colors.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.text,
    this.fontWeight,
    this.fontSize = 14,
    this.fontStyle,
    this.color = kTextColor,
    this.maxLine,
    this.height,
    this.textAlign,
  });

  final double? height;
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Color? color;
  final int? maxLine;
  final TextAlign? textAlign;

  @override
  Widget build(BuildContext context) {
    return Text(
      _getText(),
      overflow: TextOverflow.ellipsis,
      textAlign: textAlign,
      maxLines: maxLine,
      style: TextStyle(
        height: height,
        fontSize: fontSize,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        color: text.isEmpty ? kLabel : color,
      ),
    );
  }

  String _getText() {
    if (text.isEmpty) {
      return "na".tr;
    }
    return text;
  }
}
