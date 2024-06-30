import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/constant/constant.dart';
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
        GestureDetector(
          onTap: readOnly?(){
            showMessage(msg: 'not_allow_to_edit'.tr,status: Status.warning);
          }:null,
          child: AbsorbPointer(
            absorbing: readOnly,
            child: TextFormField(
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
                fillColor: kShadow,
                filled: true,
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(appSpace.scale),
                  borderSide: const BorderSide(color: Colors.red),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(appSpace.scale),
                  borderSide: const BorderSide(color: kPrimaryColor),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(appSpace.scale),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
