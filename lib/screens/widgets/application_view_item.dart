import 'package:flutter/material.dart';
import 'package:tisha_app/data/models/input_application.dart';
import 'package:tisha_app/data/models/user.dart';
import 'package:tisha_app/theme/colors.dart';
import 'package:tisha_app/theme/spaces.dart';

class ApplicationViewItem extends StatelessWidget {
  final User farmer;
  final InputApplication application;
  final Function()? onTap;
  const ApplicationViewItem({
    super.key,
    required this.farmer,
    required this.application,
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
        "${farmer.firstname} ${farmer.lastname}",
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Applied for ${application.input.name}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            CustomSpaces.verticalSpace(),
            Text(
              "🕐 ${application.createdAt.toIso8601String().substring(0, 10)}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
