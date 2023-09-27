import 'package:flutter/material.dart';
import 'package:walpapers/constants/color_const.dart';

class AppTheme {
  final theme = ThemeData.light().copyWith(
    primaryColor: AppColor.black,
    colorScheme: const ColorScheme.light()
        .copyWith(primary: AppColor.black, secondary: AppColor.black),
  );
}
