// lib/services/api_service.dart

import 'package:dio/dio.dart';
import '../models/product.dart';

class ApiService {
  static final ApiService _instance = ApiService._internal();
  factory ApiService() => _instance;

  ApiService._internal();

  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://fakestoreapi.com'));

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await _dio.get('/products');
      final List data = response.data;
      return data.map((json) => Product.fromjson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
