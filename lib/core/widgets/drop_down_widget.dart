import 'package:flutter/material.dart';

class DropDownWidget<T> extends StatelessWidget {
  final String hintText;
  final List<T> items;
  final T? value;
  final void Function(T?)? onChanged;

  const DropDownWidget({
    super.key,
    this.hintText = 'Please select a Category',
    this.items = const [],
    this.value,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) => FormField<T>(
        builder: (FormFieldState<T> state) => InputDecorator(
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 15.0,
            ),
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          isEmpty: value == null || value == '',
          child: DropdownButtonHideUnderline(
            child: DropdownButton<T>(
              value: value,
              isDense: true,
              onChanged: onChanged,
              items: items
                  .map((T value) => DropdownMenuItem<T>(
                        value: value,
                        child: Text('$value'),
                      ))
                  .toList(),
            ),
          ),
        ),
      );
}
