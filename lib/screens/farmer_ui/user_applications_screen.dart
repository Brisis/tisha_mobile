import 'package:flutter/material.dart';
import 'package:tisha_app/data/models/input_application.dart';
import 'package:tisha_app/data/models/user.dart';
import 'package:tisha_app/screens/farmer_ui/input_notifications_screen.dart';
import 'package:tisha_app/screens/widgets/user_application_item.dart';
import 'package:tisha_app/theme/colors.dart';

class InputApplicationsScreen extends StatelessWidget {
  static Route route({
    required User farmer,
    required List<UserInputApplication> applications,
  }) {
    return MaterialPageRoute(
      builder: (context) => InputApplicationsScreen(
        farmer: farmer,
        applications: applications,
      ),
    );
  }

  final User farmer;
  final List<UserInputApplication> applications;

  const InputApplicationsScreen({
    super.key,
    required this.farmer,
    required this.applications,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.kWhiteTextColor),
        backgroundColor: CustomColors.kPrimaryColor,
        elevation: 1.0,
        title: Text(
          "My Applications",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: CustomColors.kWhiteTextColor,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: applications.isNotEmpty
            ? ListView.builder(
                itemCount: applications.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: UserApplicationItem(
                      application: applications[index],
                      onTap: () {},
                    ),
                  );
                })
            : Center(
                child: Text(
                  "0 Found",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.kPrimaryColor,
        onPressed: () {
          Navigator.push(
              context, InputNotificationsScreen.route(farmer: farmer));
        },
        shape: const CircleBorder(),
        child: Icon(
          Icons.add,
          color: CustomColors.kWhiteTextColor,
        ),
      ),
    );
  }
}
