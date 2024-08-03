import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:tisha_app/theme/colors.dart';

class CustomDropDown extends StatelessWidget {
  final List<String> items;
  final String labelText;
  final String? initialText;
  final dynamic Function(String?)? onChanged;
  const CustomDropDown({
    super.key,
    required this.items,
    required this.labelText,
    this.initialText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomDropdown<String>.search(
      closedHeaderPadding: const EdgeInsets.all(8),
      initialItem: initialText,
      hintText: labelText,
      items: items,
      onChanged: onChanged,
      decoration: CustomDropdownDecoration(
        headerStyle: const TextStyle(
          fontSize: 14,
        ),
        listItemStyle: const TextStyle(
          fontSize: 14,
        ),
        noResultFoundStyle: const TextStyle(
          fontSize: 14,
        ),
        closedBorderRadius: BorderRadius.circular(8),
        closedFillColor: CupertinoColors.tertiarySystemFill,
        hintStyle: TextStyle(
          fontSize: 14,
          color: CustomColors.kLightTextColor,
        ),
        searchFieldDecoration: SearchFieldDecoration(
          textStyle: TextStyle(
            fontSize: 14,
            color: CustomColors.kLightTextColor,
          ),
        ),
      ),
    );
  }
}
