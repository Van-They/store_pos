import 'package:flutter/material.dart';
import 'package:store_pos/core/util/helper.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.scale,
      ),
    );
  }
}
