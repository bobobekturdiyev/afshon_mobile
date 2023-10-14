import 'package:afshon_ar/core/resources/app_colors.dart';
import 'package:afshon_ar/core/resources/app_icons.dart';
import 'package:afshon_ar/core/resources/styles.dart';
import 'package:afshon_ar/core/widgets/w_textfield.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WPageTitle extends StatefulWidget {
  final String title;
  final GestureTapCallback? onFilterTap;
  final GestureTapCallback? onSearchTap;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final double fontSize;
  const WPageTitle({
    Key? key,
    required this.title,
    this.onFilterTap,
    this.onSearchTap,
    this.fontSize = 32,
    this.onSubmitted,
    this.onChanged,
    this.focusNode,
  }) : super(key: key);

  @override
  State<WPageTitle> createState() => _WPageTitleState();
}

class _WPageTitleState extends State<WPageTitle> {
  bool searchOpen = false;
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        if (!searchOpen) ...{
          Flexible(
            child: Text(
              widget.title,
              style: Styles.getTextStyle(
                fontSize: widget.fontSize,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        } else ...{
          const SizedBox(),
        },
        if (widget.onSearchTap != null || widget.onFilterTap != null) ...{
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (widget.onSearchTap != null) ...{
                  Flexible(
                    child: AnimatedContainer(
                      width: !searchOpen ? 40 : 700,
                      duration: const Duration(milliseconds: 700),
                      child: !searchOpen
                          ? Align(
                              alignment: Alignment.centerRight,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    searchOpen = true;
                                  });
                                  widget.onSearchTap;
                                },
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors.primaryColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(9),
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: SvgPicture.asset(
                                    AppIcons.search,
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                            )
                          : WTextField(
                              focusNode: widget.focusNode,
                              controller: controller,
                              onSubmitted:widget.onSubmitted,
                              onChanged:widget.onChanged ,
                              margin: EdgeInsets.zero,
                              hint: "search_by_name".tr(),
                              onTapOutside: (ev) {},

                              suffixIcon: Padding(
                                padding: const EdgeInsets.all(14.0),
                                child: SvgPicture.asset(
                                  AppIcons.search,
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ),
                    ),
                  ),
                },
                if (widget.onFilterTap != null) ...{
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: widget.onFilterTap,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(9),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: SvgPicture.asset(
                        AppIcons.filter,
                        width: 20,
                        height: 20,
                      ),
                    ),
                  ),
                },
              ],
            ),
          ),
        },
      ],
    );
  }
}
