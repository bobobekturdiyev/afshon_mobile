import 'package:afshon_ar/core/resources/styles.dart';
import 'package:flutter/material.dart';

class WTitle extends StatelessWidget {
  final String title;
  final double fontSize;

  const WTitle({
    Key? key,
    required this.title,
    this.fontSize = 20,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Styles.getTextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
