import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:animated_digit/animated_digit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabber/core/constants/app_colors.dart';
import 'package:grabber/core/extensions/context_extensions.dart';
import 'package:grabber/features/home/data/models/product_model.dart';
import 'package:grabber/features/home/ui/cubit/basket_cubit.dart';

class AddAndRemoveButtons extends StatelessWidget {
  final ProductModel product;
  final GlobalKey<CartIconKey>? cartKey;
  final GlobalKey? imageKey;
  final Function(GlobalKey)? runAddToCartAnimation;

  const AddAndRemoveButtons({
    super.key,
    required this.product,
    this.cartKey,
    this.imageKey,
    this.runAddToCartAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketCubit, List<ProductModel>>(
      builder: (context, basket) {
        final inBasketIndex = basket.indexWhere((p) => p.id == product.id);
        final quantity = inBasketIndex == -1
            ? 0
            : basket[inBasketIndex].quantity;
        final inBasket = inBasketIndex != -1;

        return Container(
          height: 36,
          padding: const EdgeInsets.symmetric(horizontal: 6),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: inBasket ? BorderRadius.circular(20) : null,
            shape: inBasket ? BoxShape.rectangle : BoxShape.circle,
            border: Border.all(color: AppColors.borderWhite),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (inBasket)
                GestureDetector(
                  onTap: () {
                    context.read<BasketCubit>().removeFromBasket(product);
                    if (cartKey != null) {
                      cartKey?.currentState!.runClearCartAnimation();
                    }
                  },
                  child: const Icon(
                    Icons.remove,
                    color: AppColors.black,
                    size: 20,
                  ),
                ),
              if (inBasket) ...[
                const SizedBox(width: 8),
                AnimatedDigitWidget(
                  value: quantity,
                  textStyle: TextStyle(
                    fontSize: context.textScaler.scale(16),
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),

                const SizedBox(width: 8),
              ],
              GestureDetector(
                onTap: () async {
                  context.read<BasketCubit>().addToBasket(product);
                  if (cartKey != null && runAddToCartAnimation != null) {
                    await runAddToCartAnimation!(imageKey!);
                    await cartKey?.currentState!.runCartAnimation(
                      (quantity).toString(),
                    );
                  }
                },
                child: const Icon(Icons.add, color: AppColors.black, size: 20),
              ),
            ],
          ),
        );
      },
    );
  }
}
