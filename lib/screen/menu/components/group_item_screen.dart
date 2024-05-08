import 'package:flutter/material.dart';
import 'package:store_pos/widget/app_bar_widget.dart';

class GroupItemScreen extends StatelessWidget {
  const GroupItemScreen({super.key});
  static const String routeName = '/GroupItemScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBarWidget(title: 'group_item'),);
  }
}
