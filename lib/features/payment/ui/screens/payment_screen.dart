// 🐦 Flutter imports:
import 'package:flutter/material.dart';

// 📦 Package imports:
import 'package:credit_card_form/credit_card_form.dart';
import 'package:go_router/go_router.dart';

// 🌎 Project imports:
import 'package:grabber/application/widgets/custom_button.dart';
import 'package:grabber/application/widgets/custom_radio_button.dart';
import 'package:grabber/application/widgets/custom_tile.dart';
import 'package:grabber/application/widgets/custom_tile_background.dart';
import 'package:grabber/core/constants/app_colors.dart';
import 'package:grabber/core/constants/app_images.dart';
import 'package:grabber/core/constants/app_strings.dart';
import 'package:grabber/core/extensions/context_extensions.dart';
import 'package:grabber/core/routes/app_router.dart';
import 'package:grabber/features/payment/enum/payment_method.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  late PaymentMethod _selectedMethod;
  bool _isAnyFieldEmpty = true;
  late final CardDataInputController _cardDataInputController;

  @override
  void initState() {
    super.initState();
    _selectedMethod = PaymentMethod.applePay;
    _cardDataInputController = CardDataInputController();
  }

  @override
  void dispose() {
    _cardDataInputController.dispose();
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
          AppStrings.payment,
          style: TextStyle(
            color: Colors.black,
            fontSize: context.textScaler.scale(20),
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CustomTileBackground(
                onTap: () {
                  setState(() {
                    _selectedMethod = PaymentMethod.applePay;
                  });
                },
                spaceBetween: 10,
                children: [
                  CustomTile(
                    leading: Image.asset(
                      AppImages.applePay,
                      width: 27,
                      height: 27,
                    ),
                    title: "Apple Pay",

                    trailing: CustomRadioButton<PaymentMethod>(
                      value: PaymentMethod.applePay,
                      groupValue: _selectedMethod,
                      onChanged: (value) {
                        setState(() {
                          _selectedMethod = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              CustomTileBackground(
                onTap: () {
                  setState(() {
                    _selectedMethod = PaymentMethod.card;
                  });
                },
                spaceBetween: 10,
                children: [
                  CustomTile(
                    leading: Image.asset(
                      AppImages.craditCard,
                      width: 24,
                      height: 24,
                    ),
                    title: "Pay with card",
                    trailing: CustomRadioButton<PaymentMethod>(
                      value: PaymentMethod.card,
                      groupValue: _selectedMethod,
                      onChanged: (value) {
                        setState(() {
                          _selectedMethod = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.screenHeight * 0.05),
              _selectedMethod == PaymentMethod.card
                  ? CreditCardForm(
                      theme: CustomCardTheme(),
                      controller: _cardDataInputController,
                      hideCardHolder: true,
                      onChanged: (CardData data) {
                        if (!mounted) return;
                        setState(() {
                          _isAnyFieldEmpty =
                              data.cardNumber.isEmpty ||
                              data.expiredDate.isEmpty ||
                              data.expiredMonth.isEmpty ||
                              data.expiredYear.isEmpty ||
                              data.cvc.isEmpty ||
                              data.cvc.length != 4;
                        });
                        debugPrint(data.cardNumber);
                      },
                    )
                  : Container(),
              SizedBox(height: context.screenHeight * 0.05),
              _selectedMethod == PaymentMethod.applePay
                  ? Container()
                  : CustomButton(
                      title: "Confirm and Pay (\$49.00)",
                      onPressed: () {
                        context.push(AppPaths.trackOrder);
                      },
                      backgroundColor: _isAnyFieldEmpty
                          ? Colors.grey
                          : AppColors.green,
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCardTheme implements CreditCardTheme {
  @override
  Color backgroundColor = Colors.white;
  @override
  Color textColor = Colors.black;
  @override
  Color borderColor = Colors.black12;
  @override
  Color labelColor = Colors.black45;
}
