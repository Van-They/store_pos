import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/widget/text_widget.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({
    super.key,
    this.centerTitle = true,
    required this.title,
    this.isBack = false,
    this.onReset,
    this.isReset = false,
    this.onBack,
    this.onSearch,
    this.isSearch = false,
    this.iconSearch,
  });

  final String title;
  final bool isBack, centerTitle, isSearch, isReset;
  final VoidCallback? onBack, onSearch, onReset;
  final Widget? iconSearch;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextWidget(
        text: title,
        fontWeight: FontWeight.w600,
        fontSize: 16.scale,
      ),
      scrolledUnderElevation: 0.0,
      automaticallyImplyLeading: false,
      leading: isBack
          ? IconButton(
              onPressed: onBack ?? () => Get.back(),
              style: IconButton.styleFrom(
                backgroundColor: Colors.transparent,
                padding: EdgeInsets.zero,
                minimumSize: Size(30.scale, 30.scale),
              ),
              icon: Icon(
                Icons.arrow_back,
                size: 22.scale,
                color: kBlack,
              ),
            )
          : const SizedBox.shrink(),
      centerTitle: centerTitle,
      // leading: IconButton(
      //   onPressed: () => Get.back(),
      //   icon: Icon(
      //     Icons.arrow_back_ios_new_rounded,
      //     size: scaleFactor(22),
      //   ),
      // ),
      actions: [
        if (isSearch)
          IconButton(
            onPressed: onSearch,
            icon: iconSearch ??
                Icon(
                  Icons.search,
                  color: kPrimaryColor,
                  size: 20.scale,
                ),
          ),
        if (isReset)
          IconButton(
            onPressed: onReset,
            icon: Icon(
              Icons.restart_alt_rounded,
              color: kPrimaryColor,
              size: 24.scale,
            ),
          ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
