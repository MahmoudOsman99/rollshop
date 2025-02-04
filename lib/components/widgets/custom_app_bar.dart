import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:rollshop/core/theme/styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.isCenteredTitle,
    this.backColor,
    this.actions,
    this.leading,
    this.textStyle,
  });
  final Widget title;
  final bool? isCenteredTitle;
  final Color? backColor;
  final Widget? leading;
  final TextStyle? textStyle;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: FittedBox(
        child: title,
      ),
      centerTitle: isCenteredTitle,
      backgroundColor: backColor,
      leading: leading,
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
