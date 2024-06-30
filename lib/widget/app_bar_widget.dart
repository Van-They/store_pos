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
    this.onBack,
    this.onSearch,
    this.isSearch = false,
  });

  final String title;
  final bool isBack, centerTitle, isSearch;
  final VoidCallback? onBack, onSearch;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: TextWidget(
        text: title,
        fontSize: 18.scale,
      ),
      scrolledUnderElevation: 0.0,
      automaticallyImplyLeading: false,
      leading: isBack
          ? IconButton(
              onPressed: onBack ?? () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios_rounded,
                size: 18.scale,
                color: kPrimaryColor,
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
            icon: Icon(
              Icons.search,
              size: 20.scale,
            ),
          )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
