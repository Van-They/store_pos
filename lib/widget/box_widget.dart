import 'package:flutter/material.dart';
import 'package:store_pos/core/constant/colors.dart';
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
    this.borderRadius,
    this.alignment = Alignment.center,
    this.backgroundColor = kWhite,
    this.borderColor = kWhite,
    this.shadowColor = kShadow,
    this.enableShadow = false,
    this.blueRadius = 4,
  });

  final EdgeInsetsGeometry? padding, margin;
  final Widget? child;
  final BoxDecoration? decoration;
  final double? width, height, radius;
  final VoidCallback? onTap;
  final BorderRadiusGeometry? borderRadius;
  final AlignmentGeometry alignment;
  final Color backgroundColor, borderColor, shadowColor;
  final bool enableShadow;
  final double blueRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        alignment: alignment,
        decoration: decoration ??
            BoxDecoration(
              color: backgroundColor,
              border: Border.all(color: borderColor),
              borderRadius: borderRadius ??
                  BorderRadius.circular(radius ?? appSpace.scale),
              boxShadow: enableShadow
                  ? [
                      BoxShadow(
                        offset: const Offset(0, 0),
                        blurRadius: blueRadius,
                        color: shadowColor,
                      )
                    ]
                  : null,
            ),
        padding: padding,
        margin: margin,
        child: child,
      ),
    );
  }
}
