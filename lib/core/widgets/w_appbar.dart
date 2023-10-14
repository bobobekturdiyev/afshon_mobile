import 'package:flutter/material.dart';

import '../resources/app_colors.dart';

class WAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget leading;
  final bool isBordered;
  final bool canPop;

  const WAppBar({
    Key? key,
    required this.leading,
    this.isBordered = true,
    this.canPop = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: isBordered
            ? Border(
                bottom: BorderSide(
                  color: AppColors.C_CACACA.withOpacity(0.4),
                ),
              )
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          leading,
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size(double.infinity, 80);
}
