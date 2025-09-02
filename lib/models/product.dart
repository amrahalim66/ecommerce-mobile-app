import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String title;
  final String description;
  final double price;
  final String image;
  final double rating;
  final int count;

  const Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    required this.rating,
    required this.count,
  });

  factory Product.fromjson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      image: json['image'],
      rating: (json['rating']['rate'] as num).toDouble(),
      count: json['rating']['count'],
    );
  }

  @override
  List<Object?> get props => [id, title, price, image];
}
