import 'package:flutter/foundation.dart';

import '../../exports.dart';

class Orders {
  final String id;
  final String userId;
  final List<CartItem> cartItems;
  final int totalOrderPrice;
  final String address;
  final DateTime orderAt;
  final int status;

  const Orders({
    required this.id,
    required this.userId,
    required this.cartItems,
    required this.totalOrderPrice,
    required this.address,
    required this.orderAt,
    required this.status,
  });

  factory Orders.fromJson(Map<String, dynamic> json) => Orders(
        id: json["_id"],
        userId: json["userId"],
        cartItems: List<CartItem>.from(
            json["cartItems"].map((x) => CartItem.fromJson(x))),
        totalOrderPrice: json["totalOrderPrice"],
        address: json["address"],
        orderAt: DateTime.fromMillisecondsSinceEpoch(json["orderAt"]),
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "cartItems": List<dynamic>.from(cartItems.map((x) => x.toJson())),
        "totalOrderPrice": totalOrderPrice,
        "address": address,
        "orderAt": orderAt,
        "status": status,
      };

  Orders copyWith({
    final String? id,
    final String? userId,
    final List<CartItem>? cartItems,
    final int? totalOrderPrice,
    final String? address,
    final DateTime? orderAt,
    final int? status,
  }) =>
      Orders(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        cartItems: cartItems ?? this.cartItems,
        totalOrderPrice: totalOrderPrice ?? this.totalOrderPrice,
        address: address ?? this.address,
        orderAt: orderAt ?? this.orderAt,
        status: status ?? this.status,
      );

  @override
  String toString() =>
      'Order(id: $id, userId: $userId, cartItems: $cartItems, totalOrderPrice: $totalOrderPrice, address: $address, orderAt: $orderAt, status: $status)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Orders &&
        other.id == id &&
        other.userId == userId &&
        listEquals(other.cartItems, cartItems) &&
        other.totalOrderPrice == totalOrderPrice &&
        other.address == address &&
        other.orderAt == orderAt &&
        other.status == status;
  }

  @override
  int get hashCode => id.hashCode ^
        userId.hashCode ^
        cartItems.hashCode ^
        totalOrderPrice.hashCode ^
        address.hashCode ^
        orderAt.hashCode ^
        status.hashCode;
}
