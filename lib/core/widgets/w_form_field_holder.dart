import 'package:flutter/material.dart';

import '../resources/app_colors.dart';

class WFormFieldHolder extends StatelessWidget {
  final Widget child;
  final double verticalPadding;

  const WFormFieldHolder({
    Key? key,
    required this.child,
    this.verticalPadding = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: verticalPadding,
      ),
      margin: const EdgeInsets.only(bottom: 16, top: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(10),
        ),
        border: Border.all(
          color: AppColors.C_CACACA,
        ),
      ),
      child: child,
    );
  }
}
