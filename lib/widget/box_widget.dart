import 'package:flutter/material.dart';
import 'package:store_pos/core/util/helper.dart';

class BoxWidget extends StatelessWidget {
  const BoxWidget({
    super.key,
    this.child,
    this.margin,
    this.padding,
    this.decoration,
    this.width,
    this.height,
  });

  final EdgeInsetsGeometry? padding, margin;
  final Widget? child;
  final BoxDecoration? decoration;
  final double? width, height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: decoration ??
          BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(
              scaleFactor(appSpace),
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 0.5),
                blurRadius: 1,
                color: Colors.grey.shade400,
              )
            ],
          ),
      padding: padding ?? EdgeInsets.all(scaleFactor(appSpace)),
      margin: margin ?? EdgeInsets.all(scaleFactor(appSpace)),
      child: child,
    );
  }
}
