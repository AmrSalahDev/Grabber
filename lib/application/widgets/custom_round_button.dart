// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:grabber/core/constants/app_colors.dart';
import 'package:grabber/core/extensions/context_extensions.dart';

class CustomRoundButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  const CustomRoundButton({super.key, required this.onTap, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () => onTap(),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.borderWhite),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.black,
            fontSize: context.textScaler.scale(14),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
