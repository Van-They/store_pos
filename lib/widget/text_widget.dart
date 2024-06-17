import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.text,
    this.fontWeight,
    this.fontSize = 14,
    this.fontStyle,
    this.color,
  });
  final String text;
  final double fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: fontSize,
        fontStyle: fontStyle,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}
