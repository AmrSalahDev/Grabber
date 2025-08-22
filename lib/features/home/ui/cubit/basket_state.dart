// 📦 Package imports:
import 'package:equatable/equatable.dart';

sealed class BasketState extends Equatable {
  const BasketState();

  @override
  List<Object> get props => [];
}

final class BasketInitial extends BasketState {}
