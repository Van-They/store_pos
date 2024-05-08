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
    this.radius,
    this.onTap,
  });

  final EdgeInsetsGeometry? padding, margin;
  final Widget? child;
  final BoxDecoration? decoration;
  final double? width, height, radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration: decoration ??
            BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(radius ?? appSpace.scale),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 0.5),
                  blurRadius: 1,
                  color: Colors.grey.shade100,
                )
              ],
            ),
        padding: padding ?? EdgeInsets.all(appSpace.scale),
        margin: margin ?? EdgeInsets.all(appSpace.scale),
        child: child,
      ),
    );
  }
}
