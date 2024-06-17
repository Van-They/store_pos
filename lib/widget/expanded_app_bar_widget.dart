import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/util/helper.dart';

class ExpandedAppBarWidget extends StatelessWidget {
  const ExpandedAppBarWidget({
    super.key,
    this.isBack = true,
    required this.title,
    this.expandHeight,
    this.onBack,
    this.titlePadding,
    this.isCenterTitle = false,
    this.expandBackground,
  });
  final bool isCenterTitle;
  final Widget title;
  final Widget? expandBackground;
  final bool isBack;
  final double? expandHeight; //default 150
  final EdgeInsetsGeometry? titlePadding;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      scrolledUnderElevation: 0.0,
      expandedHeight: expandHeight ?? 90.scale,
      backgroundColor: kWhite,
      leading: IconButton(
        onPressed: onBack ?? () => Get.back(),
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          size: 18.scale,
          color: kPrimaryColor,
        ),
      ),
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.fadeTitle],
        title: title,
        centerTitle: isCenterTitle,
        collapseMode: CollapseMode.parallax,
        titlePadding: titlePadding,
        background: expandBackground,
      ),
    );
  }
}
