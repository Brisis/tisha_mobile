import 'package:flutter/material.dart';
import 'package:tisha_app/data/models/user.dart';
import 'package:tisha_app/screens/admin_ui/farmer_details_screen.dart';
import 'package:tisha_app/screens/admin_ui/farmer_inputs_screen.dart';
import 'package:tisha_app/screens/widgets/menu_item.dart';
import 'package:tisha_app/theme/colors.dart';
import 'package:tisha_app/theme/spaces.dart';

class FarmerScreen extends StatefulWidget {
  static Route route({
    required User user,
  }) {
    return MaterialPageRoute(
      builder: (context) => FarmerScreen(
        user: user,
      ),
    );
  }

  final User user;
  const FarmerScreen({super.key, required this.user});

  @override
  State<FarmerScreen> createState() => _FarmerScreenState();
}

class _FarmerScreenState extends State<FarmerScreen> {
  late User farmer;
  @override
  void initState() {
    super.initState();
    farmer = widget.user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.kWhiteTextColor),
        backgroundColor: CustomColors.kPrimaryColor,
        elevation: 1.0,
        title: Text(
          "Farmer",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: CustomColors.kWhiteTextColor,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_box_outlined,
                  color: CustomColors.kIconColor,
                  size: 80,
                ),
                CustomSpaces.verticalSpace(height: 15),
                Text(
                  farmer.email,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                CustomSpaces.verticalSpace(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.location_city,
                      color: CustomColors.kIconColor,
                    ),
                    CustomSpaces.horizontalSpace(),
                    Text(
                      farmer.location?.name ?? "No Location",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                )
              ],
            ),
            CustomSpaces.verticalSpace(height: 30),
            MenuItem(
              title: "Farmer Details",
              subTitle: farmer.name,
              icon: Icons.person,
              onTap: () {
                Navigator.push(context, FarmerDetailsScreen.route());
              },
            ),
            MenuItem(
              title: "Farmer Inputs",
              subTitle: "${farmer.inputs.length} inputs",
              icon: Icons.water_drop,
              onTap: () {
                Navigator.push(context, FarmerInputsScreen.route());
              },
            ),
          ],
        ),
      ),
    );
  }
}
