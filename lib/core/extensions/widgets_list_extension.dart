
import 'package:flutter/material.dart';

extension WidgetsList on List<Widget> {
  List<Widget> addSpaceBetween(Widget space) {
    if (isEmpty) return <Widget>[];
    if (length == 1) return this;

    final list = [first, space];

    for (int i = 1; i < length - 1; i++) {
      final child = this[i];
      list.add(child);
      list.add(space);
    }

    list.add(last);

    return list;
  }
}
