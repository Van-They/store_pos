import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:store_pos/core/util/helper.dart';
import 'package:store_pos/screen/merchant/main_merchant_screen.dart';
import 'package:store_pos/widget/app_bar_widget.dart';
import 'package:store_pos/widget/text_widget.dart';

class MenuScreen extends GetView {
  const MenuScreen({super.key});

  static const String routeName = '/MenuScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(title: 'menu'.tr),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: Icon(
                FontAwesomeIcons.heart,
                size: 22.scale,
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18.scale),
              dense: true,
              title: TextWidget(text: 'wishlist'.tr),
            ),
            ListTile(
              leading: Icon(
                Icons.language_rounded,
                size: 24.scale,
              ),
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18.scale),
              dense: true,
              title: TextWidget(text: 'language'.tr),
            ),
            ListTile(
              leading: Icon(
                Icons.dashboard_outlined,
                size: 24.scale,
              ),
              onTap: () {
                Get.toNamed(MainMerchantScreen.routeName);
              },
              trailing: Icon(Icons.arrow_forward_ios_rounded, size: 18.scale),
              dense: true,
              title: TextWidget(text: 'dashboard'.tr),
            ),
          ],
        ),
      ),
    );
  }
}
