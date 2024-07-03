import 'package:flutter/material.dart';
import 'package:store_pos/core/constant/colors.dart';
import 'package:store_pos/widget/loading_widget.dart';

class CustomScrollWidget extends StatelessWidget {
  const CustomScrollWidget({
    super.key,
    this.child,
    this.searchText = '',
    this.controller,
    this.isEmpty = false,
    this.isLoading = false,
    this.isLoadingMore = false,
    this.isScrolled = false,
    this.isSearching = false,
    this.onRefresh,
    this.sliverAppBar,
  });

  final Widget? child;
  final ScrollController? controller;
  final bool isLoading, isSearching, isLoadingMore, isScrolled, isEmpty;
  final String searchText;
  final VoidCallback? onRefresh;
  final SliverAppBar? sliverAppBar;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: kPrimaryColor,
      onRefresh: () async => onRefresh,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        controller: controller,
        slivers: [
          if(isLoading)
            const SliverFillRemaining(
              child: LoadingWidget(),
            ),
        ],
      ),
    );
  }
}
