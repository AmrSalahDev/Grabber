// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:faker/faker.dart' as faker;
import 'package:go_router/go_router.dart';

// 🌎 Project imports:
import 'package:grabber/application/widgets/custom_tile.dart';
import 'package:grabber/application/widgets/custom_tile_background.dart';
import 'package:grabber/core/constants/app_colors.dart';
import 'package:grabber/core/constants/app_images.dart';
import 'package:grabber/core/constants/app_strings.dart';
import 'package:grabber/core/extensions/context_extensions.dart';
import 'package:grabber/core/routes/app_router.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});

  @override
  State<CheckOutScreen> createState() => _CheckOutScreenState();
}

class _CheckOutScreenState extends State<CheckOutScreen> {
  bool _showBottomBar = false;
  bool isChecked = false;

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
        toolbarHeight: 70,
        elevation: 2,
        centerTitle: true,
        title: Text(
          AppStrings.checkout,
          style: TextStyle(
            color: Colors.black,
            fontSize: context.textScaler.scale(20),
            fontWeight: FontWeight.w500,
          ),
        ),
        shadowColor: Colors.black26,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          iconSize: 20,
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTileBackground(
                title: "Details",
                children: [
                  CustomTile(
                    leading: const Icon(
                      Icons.person_2_outlined,
                      color: AppColors.black,
                    ),
                    title: faker.faker.person.name(),
                  ),
                  Divider(color: AppColors.borderWhite),
                  CustomTile(
                    leading: const Icon(
                      Icons.phone_outlined,
                      color: AppColors.black,
                    ),
                    title:
                        '+${faker.faker.phoneNumber.random.numberOfLength(11)}',
                  ),
                ],
              ),
              CustomTileBackground(
                title: "Address",
                children: [
                  CustomTile(
                    leading: const Icon(
                      Icons.location_on_outlined,
                      color: AppColors.black,
                    ),
                    title: faker.faker.address.streetAddress(),
                  ),
                ],
              ),
              CustomTileBackground(
                title: "Hava Coupon?",
                children: [
                  CustomTile(
                    leading: const Icon(
                      Icons.local_offer_outlined,
                      color: AppColors.black,
                    ),
                    title: "Apply Coupon",
                  ),
                ],
              ),
              CustomTileBackground(
                title: "Delivery",
                children: [
                  CustomTile(
                    leading: Image.asset(
                      AppImages.priority,
                      width: 24,
                      height: 24,
                      color: AppColors.black,
                    ),
                    title: "Priority (10 -20 mins)",
                    trailing: Transform.scale(
                      scale: 1.2,
                      child: Radio(
                        value: isChecked,
                        groupValue: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeColor: AppColors.green,
                      ),
                    ),
                  ),
                  Divider(color: AppColors.borderWhite),
                  CustomTile(
                    leading: Image.asset(
                      AppImages.standard,
                      width: 24,
                      height: 24,
                      color: AppColors.black,
                    ),
                    title: "Standard (30 - 45 mins)",
                    trailing: Transform.scale(
                      scale: 1.2,
                      child: Radio(
                        value: isChecked,
                        groupValue: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                        visualDensity: VisualDensity.compact,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        activeColor: AppColors.green,
                      ),
                    ),
                  ),
                  Divider(color: AppColors.borderWhite),
                  CustomTile(
                    leading: const Icon(
                      Icons.schedule_outlined,
                      color: AppColors.black,
                    ),
                    title: 'Schedule',
                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Text(
                      "Order Summary (12 items)",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: context.textScaler.scale(16),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: AppColors.black,
                    ),
                  ],
                ),
              ),
              CustomTileBackground(
                children: [
                  ListTile(
                    title: Text(
                      "Subtotal",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: context.textScaler.scale(16),
                        color: AppColors.textGreyColor,
                      ),
                    ),
                    trailing: Text(
                      "\$40.25",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: context.textScaler.scale(16),
                        color: AppColors.textGreyColor,
                      ),
                    ),
                  ),

                  ListTile(
                    title: Text(
                      "Bag fee",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: context.textScaler.scale(16),
                        color: AppColors.textGreyColor,
                      ),
                    ),
                    trailing: Text(
                      "\$0.25",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: context.textScaler.scale(16),
                        color: AppColors.textGreyColor,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Service fee",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: context.textScaler.scale(16),
                        color: AppColors.textGreyColor,
                      ),
                    ),
                    trailing: Text(
                      "\$5.25",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: context.textScaler.scale(16),
                        color: AppColors.textGreyColor,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Delivery",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: context.textScaler.scale(16),
                        color: AppColors.textGreyColor,
                      ),
                    ),
                    trailing: Text(
                      "\$0.00",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: context.textScaler.scale(16),
                        color: AppColors.textGreyColor,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text(
                      "Total",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: context.textScaler.scale(16),
                        color: AppColors.textColor,
                      ),
                    ),
                    trailing: Text(
                      "\$49.00",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: context.textScaler.scale(16),
                        color: AppColors.textColor,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                    ),
                    child: ListTile(
                      title: Text(
                        "Request an invoice",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: context.textScaler.scale(16),
                          color: AppColors.textColor,
                        ),
                      ),
                      trailing: Transform.scale(
                        scale: 0.8,
                        child: Switch(
                          inactiveTrackColor: Color(0xFFCCCBCB),
                          activeColor: AppColors.green,
                          thumbColor: WidgetStatePropertyAll(AppColors.white),
                          padding: EdgeInsets.zero,
                          trackOutlineColor: WidgetStatePropertyAll(
                            Colors.transparent,
                          ),

                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              CustomTileBackground(
                title: "Payment method",
                children: [
                  ListTile(
                    leading: Image.asset(
                      AppImages.applePay,
                      width: 27,
                      height: 27,
                      color: AppColors.black,
                    ),
                    title: Text(
                      "Apple pay",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: context.textScaler.scale(16),
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 20,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.screenHeight * 0.15),
            ],
          ),
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
        onPressed: () => context.push(AppPaths.payment),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.green,
          minimumSize: Size(double.infinity, 40),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Text(
          "Place order",
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
