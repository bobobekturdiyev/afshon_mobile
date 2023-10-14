import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/styles.dart';

class WTabBar extends StatelessWidget {
  final TabController tabController;
  final List<Widget> tabs;
  final EdgeInsets padding;
  final double radius;

  const WTabBar({
    Key? key,
    required this.tabController,
    required this.tabs,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
    this.radius = 50,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        indicatorColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: TabBar(
        controller: tabController,
        indicatorColor: Colors.transparent,
        indicator: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        labelColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle:
            Styles.getTextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        indicatorWeight: 0,
        unselectedLabelColor: AppColors.C999999,
        tabs: tabs,
        isScrollable: true,
        padding: padding,
        splashBorderRadius: BorderRadius.circular(50),
        labelPadding: const EdgeInsets.symmetric(horizontal: 16),
      ),
    );
  }
}
