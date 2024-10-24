import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:store_pos/widget/text_widget.dart';

class SearchScreen extends GetView<SearchController> {
  const SearchScreen({super.key});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextWidget(text: "Search Screen"),
    );
  }
}
