import 'package:flutter/material.dart';

class CustomDropdownMenu<T> extends StatelessWidget {
  final Widget child;
  final T value;

  const CustomDropdownMenu({
    super.key,
    required this.child,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: child,
    );
  }
}
