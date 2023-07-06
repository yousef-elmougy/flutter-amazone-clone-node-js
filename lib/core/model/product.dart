import 'package:flutter/foundation.dart';

class Product {
  final String? id;
  final String name;
  final String description;
  final double price;
  final double averageRating;
  final double quantity;
  final String category;
  final List<String> images;
  final List<Ratings> ratings;

  const Product({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.averageRating,
    required this.quantity,
    required this.category,
    required this.images,
    required this.ratings,
  });

  Product copyWith({
    final String? id,
    final String? name,
    final String? description,
    final double? price,
    final double? averageRating,
    final double? quantity,
    final String? category,
    final List<String>? images,
    final List<Ratings>? ratings,
  }) =>
      Product(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        price: price ?? this.price,
        averageRating: averageRating ?? this.averageRating,
        quantity: quantity ?? this.quantity,
        category: category ?? this.category,
        images: images ?? this.images,
        ratings: ratings ?? this.ratings,
      );

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json['_id'],
        name: json['name'] ?? '',
        description: json['description'] ?? '',
        price: json['price']?.toDouble() ?? 0.0,
        averageRating: json['averageRating']?.toDouble() ?? 0.0,
        quantity: json['quantity']?.toDouble() ?? 0.0,
        category: json['category'] ?? '',
        images: List<String>.from(
          (json['images'] as List?)?.map((e) => e) ?? [],
        ),
        ratings: List<Ratings>.from(
          (json['ratings'] as List?)?.map((e) => Ratings.fromJson(e)) ?? [],
        ),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'price': price,
        'averageRating': averageRating,
        'quantity': quantity,
        'category': category,
        'images': images,
      };

  @override
  String toString() =>
      'Product(id: $id, name: $name, description: $description, price: $price, quantity: $quantity, category: $category, images: $images)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Product &&
        other.id == id &&
        other.name == name &&
        other.description == description &&
        other.price == price &&
        other.quantity == quantity &&
        other.category == category &&
        listEquals(other.images, images);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        description.hashCode ^
        price.hashCode ^
        quantity.hashCode ^
        category.hashCode ^
        images.hashCode;
  }
}

class Ratings {
  final String userId;
  final double rating;

  const Ratings({required this.userId, required this.rating});

  Ratings copyWith({final String? userId, final double? rating}) =>
      Ratings(userId: userId ?? this.userId, rating: rating ?? this.rating);

  factory Ratings.fromJson(Map<String, dynamic> json) => Ratings(
        userId: json['userId'] ?? '',
        rating: json['rating']?.toDouble() ?? 0.0,
      );

  @override
  String toString() => 'Ratings(userId: $userId, rating: $rating)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Ratings && other.userId == userId && other.rating == rating;
  }

  @override
  int get hashCode => userId.hashCode ^ rating.hashCode;
}
