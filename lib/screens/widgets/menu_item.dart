import 'package:flutter/material.dart';
import 'package:tisha_app/theme/colors.dart';

class MenuItem extends StatelessWidget {
  final String title;
  final String subTitle;
  final IconData icon;
  final Function()? onTap;
  const MenuItem({
    super.key,
    required this.title,
    required this.subTitle,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: ListTile(
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
            icon,
            color: CustomColors.kIconColor,
          ),
        ),
        title: Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            subTitle,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
      ),
    );
  }
}
