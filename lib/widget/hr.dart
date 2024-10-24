import 'package:flutter/material.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/util/helper.dart';

class Hr extends StatelessWidget {
  const Hr({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(appSpace),
        color: kBorderColor,
      ),
    );
  }
}
