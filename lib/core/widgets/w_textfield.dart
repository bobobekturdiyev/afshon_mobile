import 'package:afshon_ar/core/widgets/w_label.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/resources/app_colors.dart';
import '../../../core/resources/styles.dart';
import '../resources/app_icons.dart';

class WTextField extends StatefulWidget {
  final FocusNode? focusNode;
  final TextEditingController controller;
  final bool isObscure;
  final Widget? prefixIcon;
  final List<TextInputFormatter> formatters;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final int? maxLength;
  final int? maxLines;
  final String? errorText;
  final String? hint;
  final TextAlign textAlign;
  final TextStyle? textStyle;
  final Widget? suffixIcon;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;
  final Function(PointerDownEvent)? onTapOutside;
  final bool readOnly;
  final double hintFontSize;
  final EdgeInsets contentPadding;
  final EdgeInsets margin;
  final String? label;

  const WTextField({
    Key? key,
    this.focusNode,
    required this.controller,
    this.isObscure = false,
    this.prefixIcon,
    this.margin = const EdgeInsets.symmetric(vertical: 7),
    this.formatters = const [],
    this.keyboardType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    this.maxLength,
    this.maxLines = 1,
    this.errorText,
    this.hint,
    this.textAlign = TextAlign.start,
    this.textStyle,
    this.suffixIcon,
    this.onSubmitted,
    this.onChanged,
    this.onTapOutside,
    this.contentPadding =
        const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
    this.readOnly = false,
    this.hintFontSize = 14,
    this.label,
  }) : super(key: key);

  @override
  State<WTextField> createState() => _WTextFieldState();
}

class _WTextFieldState extends State<WTextField> {
  bool toggle = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: true,
      maxLines: widget.maxLines,
      readOnly: widget.readOnly,
      textAlign: widget.textAlign,
      focusNode: widget.focusNode,
      controller: widget.controller,
      onSubmitted: widget.onSubmitted,
      onTapOutside: widget.onTapOutside,
      style: widget.textStyle ?? Styles.getTextStyle(),
      obscureText: widget.isObscure && !toggle,
      maxLength: widget.maxLength,
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        errorText: widget.errorText != null ? "" : null,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isObscure
            ? IconButton(
                icon: toggle
                    ? SvgPicture.asset(
                        AppIcons.removedEye,
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(
                            AppColors.C999999, BlendMode.srcIn),
                      )
                    : SvgPicture.asset(
                        AppIcons.eye,
                        width: 24,
                        height: 24,
                        colorFilter: const ColorFilter.mode(
                            AppColors.C999999, BlendMode.srcIn),
                      ),
                onPressed: () {
                  setState(() {
                    toggle = !toggle;
                  });
                },
              )
            : widget.suffixIcon,
        border: getBorder(),
        enabledBorder: getBorder(),
        focusedBorder: getBorder(),
        errorBorder: getBorder(color: AppColors.danger),
        contentPadding: widget.contentPadding,
        counterText: "",
        hintText: widget.hint,
        hintStyle: Styles.getTextStyle(
          color: AppColors.C999999,
          letterSpacing: 1,
          fontSize: widget.hintFontSize,
        ),
        errorStyle: Styles.getTextStyle(fontSize: 8, color: AppColors.danger),
      ),
      textInputAction: widget.textInputAction,
      cursorColor: AppColors.primaryColor,
      keyboardType: widget.keyboardType,
      inputFormatters: widget.formatters,
    );
  }

  getBorder({Color? color}) => InputBorder.none;
}
