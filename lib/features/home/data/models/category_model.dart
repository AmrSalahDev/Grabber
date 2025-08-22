// 🌎 Project imports:
import 'package:grabber/core/constants/app_images.dart';
import 'package:grabber/core/constants/app_strings.dart';

class CategoryModel {
  final String name;
  final String image;

  CategoryModel({required this.name, required this.image});

  static final List<CategoryModel> categories = [
    CategoryModel(name: AppStrings.fruits, image: AppImages.fruits),
    CategoryModel(name: AppStrings.milkEggs, image: AppImages.milkEgg),
    CategoryModel(name: AppStrings.beverages, image: AppImages.beverages),
    CategoryModel(name: AppStrings.laundry, image: AppImages.laundry),
    CategoryModel(name: AppStrings.vegetables, image: AppImages.vegebales),
  ];
}
