import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grabber/features/home/data/models/product_model.dart';

class BasketCubit extends Cubit<List<ProductModel>> {
  BasketCubit() : super([]);

  void addToBasket(ProductModel product) {
    final index = state.indexWhere((p) => p.id == product.id);

    if (index == -1) {
      emit([...state, product.copyWith(quantity: 1)]);
    } else {
      final updated = state[index].copyWith(
        quantity: state[index].quantity + 1,
      );
      final newState = [...state];
      newState[index] = updated;
      emit(newState);
    }
  }

  void removeFromBasket(ProductModel product) {
    final index = state.indexWhere((p) => p.id == product.id);
    if (index == -1) return;

    final current = state[index];
    if (current.quantity > 1) {
      final updated = current.copyWith(quantity: current.quantity - 1);
      final newState = [...state];
      newState[index] = updated;
      emit(newState);
    } else {
      final newState = [...state]..removeAt(index);
      emit(newState);
    }
  }

  List<ProductModel> getBasket() => state;

  void clearBasket() => emit([]);

  bool isInBasket(ProductModel product) => state.any((p) => p.id == product.id);

  bool isEmpty() => state.isEmpty;
}
