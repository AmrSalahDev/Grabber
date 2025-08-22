// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:grabber/core/constants/app_colors.dart';
import 'package:grabber/core/extensions/context_extensions.dart';

class CustomTile extends StatelessWidget {
  final Widget leading;
  final String title;
  final Widget? trailing;

  const CustomTile({
    super.key,
    required this.leading,
    required this.title,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: leading,
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: context.textScaler.scale(16),
        ),
      ),
      trailing:
          trailing ??
          const Icon(Icons.arrow_forward_ios, size: 20, color: AppColors.black),
    );
  }
}
