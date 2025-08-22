// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 🌎 Project imports:
import 'package:grabber/core/constants/app_colors.dart';
import 'package:grabber/core/constants/app_images.dart';
import 'package:grabber/core/constants/app_strings.dart';
import 'package:grabber/features/order_track/enum/delivery_step.dart';

class TrackOrder extends StatelessWidget {
  final DeliveryStep currentStep;
  const TrackOrder({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Confirmed
        _buildProgressStep(
          iconPath: AppImages.confirmed,
          label: AppStrings.confirmed,
          isActive: currentStep == DeliveryStep.confirmed,
          isCompleted: currentStep.index > DeliveryStep.confirmed.index,
        ),

        _buildProgressLine(
          isCompleted: currentStep.index > DeliveryStep.confirmed.index,
        ),

        // Packing
        _buildProgressStep(
          iconPath: AppImages.packingItems,
          label: AppStrings.packingItms,
          isActive: currentStep == DeliveryStep.packing,
          isCompleted: currentStep.index > DeliveryStep.packing.index,
        ),

        _buildProgressLine(
          isCompleted: currentStep.index > DeliveryStep.packing.index,
        ),

        // Out for delivery
        _buildProgressStep(
          iconPath: AppImages.motorcycle,
          label: AppStrings.outForDelivery,
          isActive: currentStep == DeliveryStep.outForDelivery,
          isCompleted: currentStep.index > DeliveryStep.outForDelivery.index,
        ),

        _buildProgressLine(
          isCompleted: currentStep.index > DeliveryStep.outForDelivery.index,
        ),

        // Delivered
        _buildProgressStep(
          iconPath: AppImages.delivered,
          label: AppStrings.delivered,
          isActive: currentStep == DeliveryStep.delivered,
          isCompleted: false,
        ),
      ],
    );
  }

  Widget _buildProgressStep({
    required String iconPath,
    required String label,
    required bool isActive,
    required bool isCompleted,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          iconPath,
          color: isCompleted || isActive ? AppColors.green : Colors.grey[300],
          width: 24,
          height: 24,
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 8,
            color: isActive || isCompleted ? AppColors.green : Colors.grey[600],
            fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildProgressLine({required bool isCompleted}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: isCompleted ? Colors.green : Colors.grey[300],
        ),
        height: 3,
        margin: EdgeInsets.only(bottom: 20),
      ),
    );
  }
}
