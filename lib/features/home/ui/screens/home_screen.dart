import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:grabber/application/widgets/add_and_remove_buttons.dart';
import 'package:grabber/application/widgets/system_ui_wrapper.dart';
import 'package:grabber/core/constants/app_colors.dart';
import 'package:grabber/core/constants/app_images.dart';
import 'package:grabber/core/constants/app_strings.dart';
import 'package:grabber/core/extensions/context_extensions.dart';
import 'package:grabber/core/routes/app_router.dart';
import 'package:grabber/features/home/data/models/category_model.dart';
import 'package:grabber/features/home/data/models/product_model.dart';
import 'package:grabber/features/home/ui/cubit/basket_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final GlobalKey<CartIconKey> cartKey;
  late Function(GlobalKey) runAddToCartAnimation;

  @override
  void initState() {
    super.initState();
    cartKey = GlobalKey<CartIconKey>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SystemUIWrapper(
      navigationBarColor: Colors.white,
      navigationBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
      child: AddToCartAnimation(
        cartKey: cartKey,
        height: 30,
        width: 30,
        opacity: 0.85,
        dragAnimation: const DragToCartAnimationOptions(rotation: true),
        jumpAnimation: const JumpAnimationOptions(),
        createAddToCartAnimation: (runAddToCartAnimation) {
          this.runAddToCartAnimation = runAddToCartAnimation;
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            toolbarHeight: 70,
            elevation: 2,
            shadowColor: Colors.black26,
            title: _buildAppBarBody(context),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildCarouseSlider(),
                    SizedBox(height: context.screenHeight * 0.03),
                    _buildCategories(context),
                    SizedBox(height: context.screenHeight * 0.03),
                    _buildSeeAllWidget(
                      context: context,
                      title: AppStrings.fruits,
                    ),
                    SizedBox(height: context.screenHeight * 0.03),
                    _buildProducts(
                      context: context,
                      products: ProductModel.fruits,
                    ),

                    SizedBox(height: context.screenHeight * 0.03),
                    _buildSeeAllWidget(
                      context: context,
                      title: AppStrings.detergent,
                    ),
                    SizedBox(height: context.screenHeight * 0.03),
                    _buildProducts(
                      context: context,
                      products: ProductModel.detergent,
                    ),
                    SizedBox(height: context.screenHeight * 0.15),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: CustomNavigationBar(),
          floatingActionButton:
              BlocSelector<BasketCubit, List<ProductModel>, int>(
                selector: (basket) => basket.length,
                builder: (context, basketSize) {
                  return AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    transitionBuilder: (child, animation) =>
                        ScaleTransition(scale: animation, child: child),

                    child: basketSize == 0
                        ? const SizedBox.shrink()
                        : BasketBar(
                            onBasketTap: () => _showBasket(context),
                            cartKey: cartKey,
                          ),
                  );
                },
              ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
        ),
      ),
    );
  }

  void _showBasket(BuildContext parentContext) {
    showModalBottomSheet(
      context: parentContext,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),

      builder: (bottomSheetContext) {
        return BlocProvider.value(
          value: parentContext.read<BasketCubit>(),
          child: BlocBuilder<BasketCubit, List<ProductModel>>(
            builder: (context, basket) {
              return Container(
                height: context.screenHeight * 0.7,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (basket.isEmpty) const Text("No products added yet."),

                    if (basket.isNotEmpty)
                      Expanded(
                        child: ListView.builder(
                          itemCount: basket.length,
                          itemBuilder: (context, index) {
                            final product = basket[index];
                            final GlobalKey imageKey = GlobalKey();
                            return ListTile(
                              contentPadding: const EdgeInsets.all(0),
                              leading: Container(
                                key: imageKey,
                                width: 67,
                                height: 67,
                                alignment: Alignment.center,
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.productColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Image.asset(product.image, height: 40),
                              ),
                              title: Text(
                                product.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text("\$${product.price}"),
                              trailing: AddAndRemoveButtons(
                                product: product,
                                cartKey: cartKey,
                                imageKey: imageKey,
                                runAddToCartAnimation: runAddToCartAnimation,
                              ),
                            );
                          },
                        ),
                      ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        context.push(
                          AppPaths.cart,
                          extra: context.read<BasketCubit>(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.green,
                        minimumSize: const Size.fromHeight(60),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Go to Cart (\$30.99)",
                            style: TextStyle(
                              fontSize: context.textScaler.scale(16),
                              color: AppColors.white,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Badge(
                            backgroundColor: AppColors.red,
                            label: Text(
                              basket.length.toString(),
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: context.textScaler.scale(12),
                              ),
                            ),
                            child: Image.asset(
                              AppImages.basket,
                              width: 24,
                              height: 24,
                              color: AppColors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildProducts({
    required BuildContext context,
    required List<ProductModel> products,
  }) {
    return SizedBox(
      height: context.screenHeight * 0.32,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (context, index) => _buildProductItem(
          context: context,
          index: index,
          products: products,
        ),
      ),
    );
  }

  Widget _buildProductItem({
    required BuildContext context,
    required int index,
    required List<ProductModel> products,
  }) {
    final product = products[index];
    final GlobalKey imageKey = GlobalKey();
    final textStyle = TextStyle(
      fontWeight: FontWeight.w500,
      color: AppColors.textColor,
    );

    return Stack(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              key: imageKey,
              height: 150,
              width: 170,
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.productColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(
                product.image,
                fit: BoxFit.contain,
                width: double.infinity,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: textStyle.copyWith(
                    fontSize: context.textScaler.scale(16),
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: AppColors.yellow, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      product.rate,
                      style: textStyle.copyWith(
                        fontSize: context.textScaler.scale(12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '\$${product.price}',
                  style: textStyle.copyWith(
                    fontSize: context.textScaler.scale(14),
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
        Positioned(
          top: 105,
          right: 15,
          child: AddAndRemoveButtons(
            product: product,
            cartKey: cartKey,
            imageKey: imageKey,
            runAddToCartAnimation: runAddToCartAnimation,
          ),
        ),
      ],
    );
  }

  Widget _buildSeeAllWidget({
    required BuildContext context,
    required String title,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: context.textScaler.scale(16),
            fontWeight: FontWeight.w500,
            color: AppColors.textColor,
          ),
        ),
        Text(
          AppStrings.seeAll,
          style: TextStyle(
            fontSize: context.textScaler.scale(14),
            fontWeight: FontWeight.w500,
            color: AppColors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildCategories(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => _buildCategoryItem(context, index),
        itemCount: CategoryModel.categories.length,
      ),
    );
  }

  Widget _buildCategoryItem(BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LayoutBuilder(
          builder: (context, constraints) => Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(right: 10),
            width: context.screenWidth * 0.20,
            height: context.screenWidth * 0.20,
            decoration: BoxDecoration(
              color: AppColors.categoryColor,
              shape: BoxShape.circle,
            ),
            child: Image.asset(
              CategoryModel.categories[index].image,
              width: constraints.maxWidth,
              height: constraints.maxHeight,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: Text(
            CategoryModel.categories[index].name,
            style: TextStyle(
              fontSize: context.textScaler.scale(11),
              fontWeight: FontWeight.w500,
              color: AppColors.textColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCarouseSlider() {
    return CarouselSlider(
      options: CarouselOptions(
        height: 200.0,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 4),
        autoPlayAnimationDuration: Duration(milliseconds: 1300),
        autoPlayCurve: Curves.fastOutSlowIn,
        viewportFraction: 1.0,
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: AppColors.cardOfferColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.offer,
                        style: TextStyle(
                          fontSize: context.textScaler.scale(20),
                          fontWeight: FontWeight.bold,
                          color: AppColors.textColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        AppStrings.offer,
                        style: TextStyle(
                          fontSize: context.textScaler.scale(13),
                          fontWeight: FontWeight.bold,
                          color: AppColors.green,
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          AppStrings.shopNow,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: context.textScaler.scale(13),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Image.asset(
                      AppImages.vegebales,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildAppBarBody(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(AppImages.motorcycle, width: 24, height: 24),
        const SizedBox(width: 8),
        Text(
          '${faker.faker.address.buildingNumber().substring(0, 2)} ${faker.faker.address.streetName()}...',
          style: context.textTheme.titleMedium,
        ),
        IconButton(
          onPressed: () {},
          constraints: BoxConstraints(),
          icon: const Icon(Icons.keyboard_arrow_down, size: 30),
          color: Colors.black,
        ),
        Spacer(),
        InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () {},
          child: Ink(
            padding: const EdgeInsets.all(5),
            child: Image.asset(AppImages.basket, width: 24, height: 24),
          ),
        ),
      ],
    );
  }
}

class BasketBar extends StatefulWidget {
  final VoidCallback onBasketTap;
  final GlobalKey<CartIconKey> cartKey;
  const BasketBar({
    super.key,
    required this.onBasketTap,
    required this.cartKey,
  });

  @override
  State<BasketBar> createState() => _BasketBarState();
}

class _BasketBarState extends State<BasketBar> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<BasketCubit>(),
      child: BlocBuilder<BasketCubit, List<ProductModel>>(
        builder: (context, basket) {
          return Container(
            width: double.infinity,
            height: 70,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(left: 16, right: 16),
            padding: const EdgeInsets.only(left: 16, right: 16),
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 7,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    controller: _scrollController,
                    shrinkWrap: true,
                    itemCount: basket.length,
                    itemBuilder: (_, index) {
                      return Center(
                        child: Badge(
                          label: Text(
                            basket[index].quantity.toString(),
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: context.textScaler.scale(12),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          backgroundColor: AppColors.red,
                          offset: const Offset(-15, -3),
                          child: Container(
                            margin: const EdgeInsets.only(right: 10),
                            padding: const EdgeInsets.all(5),
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: AppColors.productColor,
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset(
                              basket[index].image,
                              width: 35,
                              height: 35,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(width: 10),
                VerticalDivider(
                  color: AppColors.white,
                  thickness: 1,
                  endIndent: 10,
                  indent: 10,
                ),
                GestureDetector(
                  onTap: () => widget.onBasketTap(),
                  child: Text(
                    AppStrings.viewBasket,
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: context.textScaler.scale(16),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Badge(
                  label: Text(
                    basket.length.toString(),
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: context.textScaler.scale(12),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  backgroundColor: AppColors.red,
                  child: AddToCartIcon(
                    key: widget.cartKey,
                    icon: Image.asset(
                      AppImages.basket,
                      width: 24,
                      height: 24,
                      color: AppColors.white,
                    ),
                    badgeOptions: const BadgeOptions(active: false),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CustomNavigationBar extends StatefulWidget {
  const CustomNavigationBar({super.key});

  @override
  State<CustomNavigationBar> createState() => _CustomNavigationBarState();
}

class _CustomNavigationBarState extends State<CustomNavigationBar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: BottomNavigationBar(
        backgroundColor: AppColors.white,
        elevation: 5,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        useLegacyColorScheme: false,
        selectedLabelStyle: TextStyle(
          fontSize: context.textScaler.scale(12),
          fontWeight: FontWeight.w500,
          color: AppColors.green,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: context.textScaler.scale(12),
          fontWeight: FontWeight.w500,
          color: AppColors.black,
        ),
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined, color: AppColors.black),
            label: 'Home',
            activeIcon: Icon(Icons.home, color: AppColors.green),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_border_outlined, color: Colors.black),
            label: 'Favorite',
            activeIcon: Icon(Icons.favorite, color: AppColors.green),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded, color: Colors.black),
            label: 'Search',
            activeIcon: Icon(Icons.search, color: AppColors.green),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined, color: Colors.black),
            label: 'Profile',
            activeIcon: Icon(Icons.person_2, color: AppColors.green),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_rounded, color: Colors.black),
            label: 'Menu',
            activeIcon: Icon(Icons.menu, color: AppColors.green),
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
