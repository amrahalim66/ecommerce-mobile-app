import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/product.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> allProducts; // full list
  final List<Product> filteredProducts; // filtered list

  ProductLoaded(this.allProducts, {List<Product>? filteredProducts})
    : filteredProducts = filteredProducts ?? allProducts;
}

class ProductError extends ProductState {
  final String message;
  ProductError(this.message);
}

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial());

  Future<void> fetchProductsFromJson() async {
    emit(ProductLoading());
    try {
      final String response = await rootBundle.loadString(
        'assets/data/product.json',
      );

      final Map<String, dynamic> jsonMap = json.decode(response);
      final List<dynamic> data = jsonMap['products'];

      final List<Product> products = data
          .map((e) => Product.fromjson(e))
          .toList();

      emit(ProductLoaded(products));
    } catch (e) {
      emit(ProductError('Failed to load products: $e'));
    }
  }

  void searchProducts(String query) {
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;
      if (query.isEmpty) {
        emit(ProductLoaded(currentState.allProducts));
      } else {
        final results = currentState.allProducts
            .where((p) => p.title.toLowerCase().contains(query.toLowerCase()))
            .toList();
        emit(
          ProductLoaded(currentState.allProducts, filteredProducts: results),
        );
      }
    }
  }
}
