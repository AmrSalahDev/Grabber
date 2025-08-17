import 'package:carousel_slider/carousel_slider.dart';
import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';
import 'package:grabber/application/widgets/system_ui_wrapper.dart';
import 'package:grabber/core/constants/app_colors.dart';
import 'package:grabber/core/constants/app_images.dart';
import 'package:grabber/core/constants/app_strings.dart';
import 'package:grabber/core/extensions/context_extensions.dart';

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
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          surfaceTintColor: Colors.white,
          toolbarHeight: 70,
          elevation: 5,
          shadowColor: Colors.black26,
          title: Row(
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
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
            child: Column(
              children: [
                CarouselSlider(
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
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
