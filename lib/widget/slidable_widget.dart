import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/util/helper.dart';

class SlidableWidget extends StatelessWidget {
  const SlidableWidget({
    super.key,
    required this.child,
    this.onDelete,
    this.onEdit,
    this.height,
    this.padding,
    this.margin,
  });

  final Widget child;
  final double? height;
  final EdgeInsetsGeometry? padding, margin;
  final VoidCallback? onDelete, onEdit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: padding ?? EdgeInsets.zero,
      margin: margin ?? EdgeInsets.zero,
      child: Slidable(
        closeOnScroll: true,
        endActionPane: ActionPane(
          extentRatio: 0.4,
          motion: const ScrollMotion(),
          children: [
            SizedBox(width: 4.scale),
            Expanded(
              child: GestureDetector(
                onTap: onDelete,
                child: AbsorbPointer(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(appSpace),
                      color: kErrorColor,
                    ),
                    height: double.infinity,
                    child: Icon(
                      Icons.delete,
                      color: kWhite,
                      size: 18.scale,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 4.scale),
            Expanded(
              child: GestureDetector(
                onTap: onEdit,
                child: AbsorbPointer(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(appSpace),
                      color: kPrimaryColor,
                    ),
                    height: double.infinity,
                    child: Icon(
                      Icons.edit,
                      color: kWhite,
                      size: 18.scale,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        child: AbsorbPointer(
          child: child,
        ),
      ),
    );
  }
}
