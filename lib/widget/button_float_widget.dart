import 'package:flutter/material.dart';
import 'package:store_pos/core/constant/colors.dart';

class ButtonFloatWidget extends StatelessWidget {
  const ButtonFloatWidget({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: const CircleAvatar(
        backgroundColor: kPrimaryColor,
        child: Icon(
          Icons.add,
          color: kWhite,
        ),
      ),
    );
  }
}
