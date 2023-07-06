import 'package:flutter/material.dart';

abstract class Style {
  const Style();

  /// Text Size 14
  static const textMedium_14 = TextStyle(fontWeight: FontWeight.w500);
  static const textSemiBold_14 = TextStyle(fontWeight: FontWeight.w600);
  static const textBold_14 = TextStyle(
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  /// Text Size 15
  static const textBold_15 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 15,
  );

  /// Text Size 16
  static const textNormal_16 = TextStyle(fontSize: 16);
  static const textMedium_16 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static const textBold_16 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
  );

  /// Text Size 18
  static const textNormal_18 = TextStyle(fontSize: 18);
  static const textMedium_18 = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
  );
  static const textBold_18 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 18,
  );

  /// Text Size 20
  static const textNormal_20 = TextStyle(
    fontSize: 20,
    color: Colors.black,
  );
  static const textBold_20 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: Colors.black,
  );

  /// Text Size 24
  static const textNormal_24 = TextStyle(fontSize: 24, color: Colors.black);
  static const textBold_24 = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: Colors.black,
  );

  /// Text Size 30
  static const textNormal_30 = TextStyle(fontSize: 30);
}
