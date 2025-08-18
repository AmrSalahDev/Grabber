import 'package:equatable/equatable.dart';
import 'package:grabber/core/constants/app_images.dart';
import 'package:grabber/core/constants/app_strings.dart';
import 'package:uuid/uuid.dart';

final uuid = Uuid();

class ProductModel extends Equatable {
  final String name;
  final String rate;
  final double price;
  final String image;
  final int quantity;
  final String id;

  const ProductModel({
    required this.name,
    required this.rate,
    required this.price,
    required this.image,
    required this.id,
    this.quantity = 0,
  });

  ProductModel copyWith({
    String? name,
    String? rate,
    double? price,
    String? image,
    int? quantity,
    String? id,
  }) {
    return ProductModel(
      name: name ?? this.name,
      rate: rate ?? this.rate,
      price: price ?? this.price,
      image: image ?? this.image,
      quantity: quantity ?? this.quantity,
      id: id ?? this.id,
    );
  }

  @override
  List<Object?> get props => [id];

  static final List<ProductModel> products = [
    ProductModel(
      name: AppStrings.banana,
      rate: '4.5 (255)',
      price: 20.0,
      image: AppImages.banana,
      id: uuid.v4(),
    ),
    ProductModel(
      name: AppStrings.pepper,
      rate: '4.5 (255)',
      price: 20.0,
      image: AppImages.pepper,
      id: uuid.v4(),
    ),
    ProductModel(
      name: AppStrings.orange,
      rate: '4.5 (255)',
      price: 20.0,
      image: AppImages.orange,
      id: uuid.v4(),
    ),
    ProductModel(
      name: AppStrings.pear,
      rate: '4.5 (255)',
      price: 20.0,
      image: AppImages.pear,
      id: uuid.v4(),
    ),
    ProductModel(
      name: AppStrings.appleRed,
      rate: '4.5 (255)',
      price: 20.0,
      image: AppImages.appleRed,
      id: uuid.v4(),
    ),
    ProductModel(
      name: AppStrings.appleGreen,
      rate: '4.5 (255)',
      price: 20.0,
      image: AppImages.appleGreen,
      id: uuid.v4(),
    ),
    ProductModel(
      name: AppStrings.blueberries,
      rate: '4.5 (255)',
      price: 20.0,
      image: AppImages.blueBerries,
      id: uuid.v4(),
    ),
    ProductModel(
      name: AppStrings.guava,
      rate: '4.5 (255)',
      price: 20.0,
      image: AppImages.guava,
      id: uuid.v4(),
    ),
  ];
}
