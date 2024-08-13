import 'package:flutter/material.dart';
import 'package:tisha_app/data/models/input.dart';
import 'package:tisha_app/data/models/user.dart';
import 'package:tisha_app/theme/colors.dart';

class ApplicationItem extends StatelessWidget {
  final User farmer;
  final DateTime date;
  final Input input;
  final Function()? onTap;
  const ApplicationItem({
    super.key,
    required this.farmer,
    required this.date,
    required this.input,
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
        backgroundColor: CustomColors.kBorderColor,
        child: Icon(
          Icons.water_drop,
          color: CustomColors.kIconColor,
        ),
      ),
      title: Text(
        "${farmer.name} ${farmer.surname}",
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          "Applied for ${input.name} on ${date.toIso8601String().substring(0, 10)}",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
