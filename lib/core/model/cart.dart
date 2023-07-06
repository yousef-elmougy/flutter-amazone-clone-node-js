import 'package:flutter/foundation.dart';

import '../../exports.dart';

class Cart {
  final String userId;
  final int subtotal;
  final String id;
  final List<CartItem> cartItems;

  const Cart({
    required this.userId,
    required this.subtotal,
    required this.id,
    required this.cartItems,
  });

  factory Cart.fromJson(Map<String, dynamic> json) => Cart(
        userId: json["userId"],
        subtotal: json["subtotal"],
        id: json["_id"],
        cartItems: List<CartItem>.from(
            json["cartItems"].map((x) => CartItem.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "subtotal": subtotal,
        "_id": id,
        "cartItems": List<dynamic>.from(cartItems.map((x) => x.toJson())),
      };

  Cart copyWith({
    final String? userId,
    final int? subtotal,
    final String? id,
    final List<CartItem>? cartItems,
  }) =>
      Cart(
        userId: userId ?? this.userId,
        subtotal: subtotal ?? this.subtotal,
        id: id ?? this.id,
        cartItems: cartItems ?? this.cartItems,
      );

  @override
  String toString() =>
      'Cart(userId: $userId, subtotal: $subtotal, id: $id, cartItems: $cartItems)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Cart &&
        other.userId == userId &&
        other.subtotal == subtotal &&
        other.id == id &&
        listEquals(other.cartItems, cartItems);
  }

  @override
  int get hashCode {
    return userId.hashCode ^
        subtotal.hashCode ^
        id.hashCode ^
        cartItems.hashCode;
  }
}

class CartItem {
  final Product product;
  final int quantity;
  final String id;

  const CartItem({
    required this.product,
    required this.quantity,
    required this.id,
  });

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        product: Product.fromJson(json["product"]),
        quantity: json["quantity"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "product": product.toJson(),
        "quantity": quantity,
        "_id": id,
      };

  CartItem copyWith({
    final Product? product,
    final int? quantity,
    final String? id,
  }) =>
      CartItem(
        product: product ?? this.product,
        quantity: quantity ?? this.quantity,
        id: id ?? this.id,
      );


  @override
  String toString() =>
      'CartItem(product: $product, quantity: $quantity, id: $id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CartItem &&
        other.product == product &&
        other.quantity == quantity &&
        other.id == id;
  }

  @override
  int get hashCode => product.hashCode ^ quantity.hashCode ^ id.hashCode;
}
