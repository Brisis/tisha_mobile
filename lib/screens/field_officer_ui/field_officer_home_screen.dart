import 'package:flutter/material.dart';
import 'package:tisha_app/screens/field_officer_ui/input_notifications_screen.dart';
import 'package:tisha_app/screens/field_officer_ui/input_requests_screen.dart';
import 'package:tisha_app/screens/profile_screen.dart';
import 'package:tisha_app/screens/widgets/menu_item.dart';
import 'package:tisha_app/theme/colors.dart';

class FieldOfficerHomeScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const FieldOfficerHomeScreen(),
    );
  }

  const FieldOfficerHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.kPrimaryColor,
        elevation: 1.0,
        automaticallyImplyLeading: false,
        title: Text(
          "GovFarmInputTracker",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.bold,
                color: CustomColors.kWhiteTextColor,
              ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, ProfileScreen.route());
            },
            icon: Icon(
              Icons.account_circle_rounded,
              color: CustomColors.kWhiteTextColor,
              size: 28,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            MenuItem(
              title: "Input Requests",
              subTitle: "approve/denies request",
              icon: Icons.approval,
              onTap: () {
                Navigator.push(context, InputRequestsScreen.route());
              },
            ),
            MenuItem(
              title: "Notifications",
              subTitle: "notify farmers",
              icon: Icons.notifications,
              onTap: () {
                Navigator.push(context, InputNotificationsScreen.route());
              },
            ),
          ],
        ),
      ),
    );
  }
}
