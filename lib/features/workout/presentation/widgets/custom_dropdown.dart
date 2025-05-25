import 'package:flutter/material.dart';
import '../../../../core/extensions/context_extension.dart';
import 'custom_dropdown_menu.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? value;
  final String labelText;
  final String hintText;
  final List<DropdownMenuItem<T>> items;
  final void Function(T?)? onChanged;
  final bool isDense;
  final double? menuMaxHeight;
  final String? Function(T?)? validator;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.labelText,
    required this.hintText,
    required this.items,
    required this.onChanged,
    this.isDense = true,
    this.menuMaxHeight,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ButtonTheme(
      alignedDropdown: true,
      child: DropdownButtonFormField<T>(
        value: value,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          filled: true,
          fillColor:
              theme.brightness == Brightness.light ? Colors.grey[100] : const Color(0xFF2C2C2C),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.lowValue),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.lowValue),
            borderSide: BorderSide(
              color: theme.brightness == Brightness.light
                  ? Colors.grey[300]!
                  : const Color(0xFF3C3C3C),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(context.lowValue),
            borderSide: BorderSide(
              color: theme.colorScheme.primary,
              width: 2,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
            horizontal: context.lowValue,
            vertical: context.lowValue / 2,
          ),
        ),
        menuMaxHeight: menuMaxHeight,
        icon: Icon(
          Icons.arrow_drop_down,
          color: theme.brightness == Brightness.light ? Colors.black54 : Colors.white70,
          size: 28,
        ),
        dropdownColor:
            theme.brightness == Brightness.light ? Colors.white : const Color(0xFF2C2C2C),
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.brightness == Brightness.light ? Colors.black87 : Colors.white,
        ),
        items: items
            .map((item) => DropdownMenuItem<T>(
                  value: item.value,
                  child: CustomDropdownMenu<T>(
                    value: item.value as T,
                    child: item.child,
                  ),
                ))
            .toList(),
        selectedItemBuilder: (context) => items
            .map((item) => Container(
                  alignment: AlignmentDirectional.centerStart,
                  child: item.child,
                ))
            .toList(),
        onChanged: onChanged,
        validator: validator,
        isExpanded: true,
        itemHeight: 48,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
