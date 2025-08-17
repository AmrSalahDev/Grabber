import 'package:carousel_slider/carousel_slider.dart';
import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';
import 'package:grabber/application/widgets/system_ui_wrapper.dart';
import 'package:grabber/core/constants/app_colors.dart';
import 'package:grabber/core/constants/app_images.dart';
import 'package:grabber/core/constants/app_strings.dart';
import 'package:grabber/core/extensions/context_extensions.dart';
import 'package:grabber/features/home/data/models/category_model.dart';
import 'package:grabber/features/home/data/models/product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
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
                  _buildCategories(),
                  SizedBox(height: context.screenHeight * 0.03),
                  _buildSeeAllFruitsWidget(context),
                  SizedBox(height: context.screenHeight * 0.03),
                  _buildProducts(),
                  SizedBox(height: context.screenHeight * 0.03),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: CustomNavigationBar(),
      ),
    );
  }

  Widget _buildSeeAllFruitsWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          AppStrings.fruits,
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

  Widget _buildProducts() {
    return SizedBox(
      height: 225,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => _buildProductItem(index),
        itemCount: ProductModel.products.length,
      ),
    );
  }

  Widget _buildProductItem(int index) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 15),
              width: 160,
              height: 150,
              decoration: BoxDecoration(
                color: AppColors.productColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Image.asset(
                ProductModel.products[index].image,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ProductModel.products[index].name,
                  style: TextStyle(
                    fontSize: context.textScaler.scale(16),
                    fontWeight: FontWeight.w500,
                    color: AppColors.textColor,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    Icon(Icons.star, color: AppColors.yellow, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      ProductModel.products[index].rate,
                      style: TextStyle(
                        fontSize: context.textScaler.scale(12),
                        fontWeight: FontWeight.w500,
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '\$${ProductModel.products[index].price.toString()}',
                  style: TextStyle(
                    fontSize: context.textScaler.scale(14),
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
        Positioned(
          top: 0,
          right: 20,
          bottom: -25,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.add, color: AppColors.black, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) => _buildCategoryItem(index),
        itemCount: CategoryModel.categories.length,
      ),
    );
  }

  Widget _buildCategoryItem(int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        LayoutBuilder(
          builder: (context, constraints) => Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.only(right: 10),
            width: 70,
            height: 70,
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
                    child: Image.asset(AppImages.vegebales, fit: BoxFit.cover),
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
