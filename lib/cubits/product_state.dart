import 'package:equatable/equatable.dart';
import 'package:to_do_app/models/product.dart';
import '../../models/product.dart';

abstract class ProductState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;

  ProductLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class ProductError extends ProductState {
  final String error;

  ProductError(this.error);

  @override
  List<Object?> get props => [error];
}
