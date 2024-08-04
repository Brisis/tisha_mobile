import 'package:flutter/material.dart';
import 'package:tisha_app/screens/admin_ui/add_input_screen.dart';
import 'package:tisha_app/screens/widgets/input_item.dart';
import 'package:tisha_app/theme/colors.dart';

class FarmerInputsScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const FarmerInputsScreen(),
    );
  }

  const FarmerInputsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.kWhiteTextColor),
        backgroundColor: CustomColors.kPrimaryColor,
        elevation: 1.0,
        title: Text(
          "Registered Inputs",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: CustomColors.kWhiteTextColor,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InputItem(
                  name: "Maize Seeds",
                  farmers: 10,
                  onTap: () {},
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.kPrimaryColor,
        onPressed: () {
          Navigator.push(context, AddInputScreen.route());
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
