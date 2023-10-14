import 'package:afshon_ar/core/resources/app_colors.dart';
import 'package:flutter/material.dart';

class WFormLoader extends StatelessWidget {
  final bool isDark;

  const WFormLoader({
    Key? key,
    this.isDark = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: isDark
            ? AppColors.black.withOpacity(0.7)
            : Colors.white.withOpacity(0.7),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: AppColors.primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
