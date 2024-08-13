import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String hintText;
  final String? selectedItem;
  final void Function(String?)? onChanged;
  final List<String> items;
  const CustomDropdown({
    super.key,
    required this.hintText,
    this.selectedItem,
    this.onChanged,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedItem,
      hint: Text(hintText),
      icon: const Icon(Icons.keyboard_arrow_down),
      isExpanded: true,
      padding: const EdgeInsets.symmetric(vertical: 8),
      items: items.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Text(items),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
