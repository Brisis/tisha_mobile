import 'package:flutter/material.dart';
import 'package:tisha_app/data/models/user.dart';
import 'package:tisha_app/theme/colors.dart';
import 'package:tisha_app/theme/spaces.dart';

class FeedbackItem extends StatelessWidget {
  final User farmer;
  final String message;
  final DateTime date;
  final Function()? onTap;
  const FeedbackItem({
    super.key,
    required this.farmer,
    required this.message,
    required this.date,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: CustomColors.kBorderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${farmer.firstname} ${farmer.lastname}",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: CustomColors.kBoldTextColor,
                    ),
              ),
              Text(
                "🕐 ${date.toIso8601String().substring(0, 10)}",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          CustomSpaces.verticalSpace(),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
