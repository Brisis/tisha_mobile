import 'package:flutter/material.dart';
import 'package:tisha_app/theme/colors.dart';

class InputItem extends StatelessWidget {
  final String name;
  final int quantity;
  final String unit;
  final Function()? onTap;
  const InputItem({
    super.key,
    required this.name,
    required this.quantity,
    required this.unit,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(3.0),
      shape: OutlineInputBorder(
        borderSide: BorderSide(
          color: CustomColors.kBorderColor,
        ),
      ),
      onTap: onTap,
      leading: CircleAvatar(
        maxRadius: 40,
        backgroundColor: CustomColors.kContainerBackgroundColor,
        child: Icon(
          Icons.person,
          color: CustomColors.kIconColor,
        ),
      ),
      title: Text(
        name,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          "$quantity $unit",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
