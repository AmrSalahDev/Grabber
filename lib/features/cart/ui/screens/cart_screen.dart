// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:go_router/go_router.dart';

// 🌎 Project imports:
import 'package:grabber/application/widgets/add_and_remove_buttons.dart';
import 'package:grabber/core/constants/app_colors.dart';
import 'package:grabber/core/constants/app_images.dart';
import 'package:grabber/core/constants/app_strings.dart';
import 'package:grabber/core/extensions/context_extensions.dart';
import 'package:grabber/core/routes/app_router.dart';
import 'package:grabber/features/home/data/models/product_model.dart';
import 'package:grabber/features/home/ui/cubit/basket_cubit.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _showBottomBar = false;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _showBottomBar = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: AppColors.white,
        backgroundColor: AppColors.white,
        centerTitle: true,
        toolbarHeight: 70,
        elevation: 2,
        shadowColor: Colors.black26,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          iconSize: 20,
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          AppStrings.cart,
          style: TextStyle(
            color: Colors.black,
            fontSize: context.textScaler.scale(20),
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(AppImages.order, width: 20, height: 20),
              const SizedBox(width: 10),
              Text(
                AppStrings.orders,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: context.textScaler.scale(16),
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: Column(
          children: [
            BlocBuilder<BasketCubit, List<ProductModel>>(
              builder: (context, basket) {
                return Expanded(
                  child: AnimationLimiter(
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: basket.length,
                      itemBuilder: (context, index) {
                        final product = basket[index];

                        return AnimationConfiguration.staggeredList(
                          position: index,
                          duration: const Duration(milliseconds: 375),
                          child: SlideAnimation(
                            verticalOffset: 50.0,
                            child: FadeInAnimation(
                              child: Container(
                                height: 111,
                                margin: const EdgeInsets.only(bottom: 10),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppColors.borderWhite,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 111,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        color: AppColors.productColor,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Image.asset(
                                        product.image,
                                        width: 75,
                                        height: 60,
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          right: 10,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              product.name,
                                              style: TextStyle(
                                                fontSize: context.textScaler
                                                    .scale(16),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            Text(
                                              '\$${product.price.toString()}',
                                              style: TextStyle(
                                                fontSize: context.textScaler
                                                    .scale(16),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.bottomRight,
                                              child: AddAndRemoveButtons(
                                                product: product,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: AnimatedSlide(
        duration: const Duration(milliseconds: 600),
        offset: _showBottomBar ? Offset.zero : const Offset(0, 1),
        curve: Curves.fastOutSlowIn,
        child: _buildBottomBar(),
      ),
    );
  }

  Widget _buildBottomBar() {
    return Container(
      height: 125,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 35),
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: ElevatedButton(
        onPressed: () => context.push(AppPaths.checkout),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.green,
          minimumSize: Size(double.infinity, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          AppStrings.goToCheckout,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
