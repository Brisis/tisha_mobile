import 'package:flutter/material.dart';
import 'package:tisha_app/data/models/user.dart';
import 'package:tisha_app/theme/colors.dart';
import 'package:tisha_app/theme/spaces.dart';

class FarmerDetailsScreen extends StatelessWidget {
  static Route route({required User farmer}) {
    return MaterialPageRoute(
      builder: (context) => FarmerDetailsScreen(
        farmer: farmer,
      ),
    );
  }

  final User farmer;

  const FarmerDetailsScreen({
    super.key,
    required this.farmer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.kWhiteTextColor),
        backgroundColor: CustomColors.kPrimaryColor,
        elevation: 1.0,
        title: Text(
          "Farmer Details",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: CustomColors.kWhiteTextColor,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Name:",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: CustomColors.kBoldTextColor,
                      ),
                ),
                CustomSpaces.horizontalSpace(),
                Expanded(
                  child: Text(
                    "${farmer.name} ${farmer.surname}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            CustomSpaces.verticalSpace(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "D.O.B:",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: CustomColors.kBoldTextColor,
                      ),
                ),
                CustomSpaces.horizontalSpace(),
                Expanded(
                  child: Text(
                    "${farmer.dob?.toIso8601String().substring(0, 10)}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            CustomSpaces.verticalSpace(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Age:",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: CustomColors.kBoldTextColor,
                      ),
                ),
                CustomSpaces.horizontalSpace(),
                Expanded(
                  child: Text(
                    "${farmer.age}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            CustomSpaces.verticalSpace(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Gender:",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: CustomColors.kBoldTextColor,
                      ),
                ),
                CustomSpaces.horizontalSpace(),
                Expanded(
                  child: Text(
                    "${farmer.gender?.name}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            CustomSpaces.verticalSpace(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Phone:",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: CustomColors.kBoldTextColor,
                      ),
                ),
                CustomSpaces.horizontalSpace(),
                Expanded(
                  child: Text(
                    "${farmer.phone}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            CustomSpaces.verticalSpace(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Physical Address:",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: CustomColors.kBoldTextColor,
                      ),
                ),
                CustomSpaces.horizontalSpace(),
                Expanded(
                  child: Text(
                    "${farmer.address}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            CustomSpaces.verticalSpace(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "National ID:",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: CustomColors.kBoldTextColor,
                      ),
                ),
                CustomSpaces.horizontalSpace(),
                Expanded(
                  child: Text(
                    "${farmer.nationalId}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            CustomSpaces.verticalSpace(height: 15),
            Text(
              "Farm Details",
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: CustomColors.kBoldTextColor,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            CustomSpaces.verticalSpace(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Farm Size:",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: CustomColors.kBoldTextColor,
                      ),
                ),
                CustomSpaces.horizontalSpace(),
                Expanded(
                  child: Text(
                    "${farmer.farmSize}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            CustomSpaces.verticalSpace(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Location:",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: CustomColors.kBoldTextColor,
                      ),
                ),
                CustomSpaces.horizontalSpace(),
                Expanded(
                  child: Text(
                    "${farmer.location?.name}, ${farmer.location?.city}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            CustomSpaces.verticalSpace(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Coordinates:",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: CustomColors.kBoldTextColor,
                      ),
                ),
                CustomSpaces.horizontalSpace(),
                Expanded(
                  child: Text(
                    "${farmer.coordinates}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            CustomSpaces.verticalSpace(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Land Ownership:",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: CustomColors.kBoldTextColor,
                      ),
                ),
                CustomSpaces.horizontalSpace(),
                Expanded(
                  child: Text(
                    "${farmer.landOwnership?.name}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            CustomSpaces.verticalSpace(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Farmer Type:",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: CustomColors.kBoldTextColor,
                      ),
                ),
                CustomSpaces.horizontalSpace(),
                Expanded(
                  child: Text(
                    "${farmer.farmerType?.name}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            CustomSpaces.verticalSpace(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Crop Type:",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: CustomColors.kBoldTextColor,
                      ),
                ),
                CustomSpaces.horizontalSpace(),
                Expanded(
                  child: Text(
                    "${farmer.cropType?.name}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            CustomSpaces.verticalSpace(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Livestock Type:",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: CustomColors.kBoldTextColor,
                      ),
                ),
                CustomSpaces.horizontalSpace(),
                Expanded(
                  child: Text(
                    "${farmer.livestockType?.name}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
            CustomSpaces.verticalSpace(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Livestock Number:",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: CustomColors.kBoldTextColor,
                      ),
                ),
                CustomSpaces.horizontalSpace(),
                Expanded(
                  child: Text(
                    "${farmer.livestockNumber}",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
