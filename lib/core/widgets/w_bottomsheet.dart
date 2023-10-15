import 'package:afshon_ar/core/widgets/w_close_button.dart';
import 'package:flutter/material.dart';

import '../resources/app_colors.dart';
import '../resources/styles.dart';

class WBottomSheet extends StatelessWidget {
  final String title;
  final Widget? prefix;
  final Widget? body;

  const WBottomSheet({
    Key? key,
    required this.title,
    this.body,
    this.prefix,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 32),
          decoration: const BoxDecoration(
            color: AppColors.cardColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(24),
              topLeft: Radius.circular(24),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      if (prefix != null) ...{
                        prefix!,
                        const SizedBox(width: 12),
                      },
                      Text(
                        title,
                        style: Styles.getTextStyle(
                          fontSize: 20,
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                  const WCloseButton(),
                ],
              ),
              const SizedBox(height: 16),
              if (body != null) ...{
                body!,
              },
            ],
          ),
        ),
      ],
    );
  }
}
