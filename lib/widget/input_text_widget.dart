import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_pos/core/util/helper.dart';

class InputTextWidget extends StatelessWidget {
  const InputTextWidget({
    super.key,
    this.isDense = true,
    this.autofocus = false,
    this.contentPadding,
    this.controller,
    this.textInputType,
     
  });

  final bool isDense, autofocus;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputType? textInputType;
  

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autofocus,
      controller: controller,
      keyboardType: textInputType,
      decoration: InputDecoration(
        contentPadding: contentPadding ??
            EdgeInsets.symmetric(
              horizontal: appSpace.scale,
              vertical: appSpace.scale,
            ),
        isDense: isDense,
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(appSpace.scale),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(appSpace.scale),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(appSpace.scale),
        ),
      ),
    );
  }
}
