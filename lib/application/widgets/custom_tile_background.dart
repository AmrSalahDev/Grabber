// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:grabber/core/constants/app_styles.dart';
import 'package:grabber/core/extensions/context_extensions.dart';

class CustomTileBackground extends StatelessWidget {
  final String? title;
  final double? spaceBetween;
  final VoidCallback? onTap;
  final List<Widget> children;

  const CustomTileBackground({
    super.key,
    this.title,
    required this.children,
    this.spaceBetween,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          title == null
              ? const SizedBox.shrink()
              : Text(
                  title ?? '',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: context.textScaler.scale(16),
                    fontWeight: FontWeight.bold,
                  ),
                ),
          SizedBox(height: spaceBetween ?? 20),
          Container(
            decoration: AppStyles.boxDecoration,
            child: Column(children: children),
          ),
          SizedBox(height: spaceBetween ?? 20),
        ],
      ),
    );
  }
}
