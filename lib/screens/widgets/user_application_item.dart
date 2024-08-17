import 'package:flutter/material.dart';
import 'package:tisha_app/data/models/enums.dart';
import 'package:tisha_app/data/models/input_application.dart';
import 'package:tisha_app/theme/colors.dart';
import 'package:tisha_app/theme/spaces.dart';

class UserApplicationItem extends StatelessWidget {
  final UserInputApplication application;
  final Function()? onTap;
  const UserApplicationItem({
    super.key,
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
        application.input.name,
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
              application.status == ApplicationStatus.ACCEPTED
                  ? "Status: Approved"
                  : application.status == ApplicationStatus.REJECTED
                      ? "Status: Rejected"
                      : "Status: In Progress",
              style: Theme.of(context).textTheme.bodySmall,
            ),
            CustomSpaces.verticalSpace(),
            Text(
              "Applied on ${application.createdAt.toIso8601String().substring(0, 10)}",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
