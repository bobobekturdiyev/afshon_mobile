import 'package:afshon_ar/core/resources/app_colors.dart';
import 'package:afshon_ar/core/resources/styles.dart';
import 'package:afshon_ar/presentation/main/data/models/subject_dto.dart';
import 'package:afshon_ar/presentation/objects/presentation/pages/objects_screen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class WSubject extends StatelessWidget {
  final SubjectDto subjectDto;

  const WSubject({
    Key? key,
    required this.subjectDto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => const ObjectsScreen(),
          ),
        );
      },
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
                imageUrl: subjectDto.image,
                width: 16,
                height: 16,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              subjectDto.title,
              style: Styles.getTextStyle(),
            ),
          ],
        ),
      ),
    );
  }
}
