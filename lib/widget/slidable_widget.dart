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
  });

  final Widget child;
  final VoidCallback? onDelete, onEdit;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      closeOnScroll: true,
      endActionPane: ActionPane(
        extentRatio: 0.4,
        motion: const ScrollMotion(),
        children: [
          Expanded(
            child: GestureDetector(
              onTap: onDelete,
              child: AbsorbPointer(
                child: Container(
                  color: kErrorColor,
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
          Expanded(
            child: GestureDetector(
              onTap: onEdit,
              child: AbsorbPointer(
                child: Container(
                  color: kPrimaryColor,
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
    );
  }
}
