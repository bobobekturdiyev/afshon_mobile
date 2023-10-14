import 'package:afshon_ar/core/resources/app_colors.dart';
import 'package:afshon_ar/core/resources/app_icons.dart';
import 'package:afshon_ar/core/resources/styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ObjectsScreen extends StatefulWidget {
  const ObjectsScreen({Key? key}) : super(key: key);

  @override
  State<ObjectsScreen> createState() => _ObjectsScreenState();
}

class _ObjectsScreenState extends State<ObjectsScreen> {
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        appBar: PreferredSize(
          preferredSize: const Size(double.infinity, 72),
          child: Container(
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
              color: Color(0xFF4D4D4D),
            ))),
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      child: SvgPicture.asset(
                        AppIcons.arrowLeft,
                        colorFilter: const ColorFilter.mode(
                            AppColors.white, BlendMode.srcIn),
                      ),
                    ),
                  ),
                ),
                Text(
                  "Anatomiya",
                  style: Styles.getTextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
        body: ListView.separated(
          separatorBuilder: (_, index) => const Divider(
            color: Color(0xFF4D4D4D),
            height: 1,
          ),
          itemBuilder: (_, index) => ListTile(
            leading: Container(
              width: 40,
              height: 40,
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
            title: Text(
              "Ear",
              style: Styles.getTextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500),
            ),
            subtitle: Text(
              "Nulla condimentum vitae nunc at auctor.",
              style: Styles.getTextStyle(
                  fontSize: 12, color: const Color(0xFF7C7C7C)),
            ),
          ),
          itemCount: 5,
        ),
      ),
    );
  }
}
