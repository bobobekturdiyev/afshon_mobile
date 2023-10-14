import 'package:afshon_ar/core/resources/app_colors.dart';
import 'package:afshon_ar/core/resources/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WSubject extends StatelessWidget {
  final GestureTapCallback onTap;

  const WSubject({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        constraints: const BoxConstraints(
          minWidth: 150,
        ),
        decoration: BoxDecoration(
          color: AppColors.cardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: const BoxDecoration(
                color: Color(0xFF262839),
                shape: BoxShape.circle,
              ),
              child: CachedNetworkImage(
                imageUrl:
                    "https://static.vecteezy.com/system/resources/previews/024/044/167/original/happy-panda-clipart-transparent-background-free-png.png",
                width: 16,
                height: 16,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              "Anatomiya",
              style: Styles.getTextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
