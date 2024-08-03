import 'package:flutter/material.dart';
import 'package:tisha_app/screens/admin_ui/farmers_screen.dart';
import 'package:tisha_app/screens/admin_ui/inputs_screen.dart';
import 'package:tisha_app/screens/admin_ui/locations_screen.dart';
import 'package:tisha_app/theme/colors.dart';

class AdminHomeScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const AdminHomeScreen(),
    );
  }

  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.kPrimaryColor,
        elevation: 1.0,
        automaticallyImplyLeading: false,
        title: Text(
          "Tisha App",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: CustomColors.kWhiteTextColor,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.account_box_outlined,
              color: CustomColors.kIconColor,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MenuItem(
              title: "Registered Farmers",
              subTitle: "100 farmers",
              icon: Icons.people,
              onTap: () {
                Navigator.push(context, FarmersScreen.route());
              },
            ),
            MenuItem(
              title: "Inputs",
              subTitle: "100 inputs",
              icon: Icons.water_drop_outlined,
              onTap: () {
                Navigator.push(context, InputsScreen.route());
              },
            ),
            MenuItem(
              title: "Locations",
              subTitle: "100 cities",
              icon: Icons.location_city,
              onTap: () {
                Navigator.push(context, LocationsScreen.route());
              },
            ),
          ],
        ),
      ),
    );
  }
}

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
