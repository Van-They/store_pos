import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/widget/text_widget.dart';

class InputTextWidget extends StatelessWidget {
  const InputTextWidget({
    super.key,
    this.isDense = false,
    this.autofocus = false,
    this.contentPadding,
    this.controller,
    this.textInputType,
    this.inputFormatter,
    this.validator,
    this.obscureText = false,
    this.readOnly = false,
    this.labelOuter = '',
    this.hintText,
    this.maxLine,
    this.maxLength,
    this.suffixIcon,
    this.onTap,
  });

  final bool isDense, autofocus;
  final TextEditingController? controller;
  final EdgeInsetsGeometry? contentPadding;
  final TextInputType? textInputType;
  final List<TextInputFormatter>? inputFormatter;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final bool obscureText;
  final bool readOnly;
  final String labelOuter;
  final String? hintText;
  final int? maxLine, maxLength;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (labelOuter.isNotEmpty) TextWidget(text: labelOuter),
        if (labelOuter.isNotEmpty) SizedBox(height: 4.scale),
        TextFormField(
          autofocus: autofocus,
          controller: controller,
          keyboardType: textInputType,
          inputFormatters: inputFormatter,
          obscureText: obscureText,
          validator: validator,
          cursorColor: Colors.blueAccent,
          cursorErrorColor: Colors.red,
          readOnly: readOnly,
          maxLength: maxLength,
          maxLines: maxLine,
          obscuringCharacter: '*',
          onTap: onTap,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          decoration: InputDecoration(
            contentPadding: contentPadding ?? EdgeInsets.all(appSpace.scale),
            isDense: isDense,
            hintText: hintText,
            suffixIcon: suffixIcon,
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
        ),
      ],
    );
  }
}
