import 'package:flutter/material.dart';
import 'package:overload_pro_app/core/extensions/context_extension.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.controller,
    required this.labelText,
    required this.hintText,
    super.key,
    this.keyboardType,
    this.validator,
    this.maxLines,
  });
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(context.lowValue),
        ),
        contentPadding: context.paddingMedium,
      ),
      style: context.bodyMedium,
      keyboardType: keyboardType,
      validator: validator,
      maxLines: maxLines ?? 1,
    );
  }
}
