import 'package:grabber/core/constants/app_strings.dart';

class ProductModel {
  final String name;
  final String rate;
  final double price;
  final String image;

  ProductModel({
    required this.name,
    required this.rate,
    required this.price,
    required this.image,
  });

  static final List<ProductModel> products = [
    ProductModel(
      name: AppStrings.banana,
      rate: '4.5 (255)',
      price: 20.0,
      image: 'assets/images/banana.png',
    ),
    ProductModel(
      name: AppStrings.pepper,
      rate: '4.5 (255)',
      price: 20.0,
      image: 'assets/images/pepper.png',
    ),
    ProductModel(
      name: AppStrings.orange,
      rate: '4.5 (255)',
      price: 20.0,
      image: 'assets/images/orange.png',
    ),
  ];
}
