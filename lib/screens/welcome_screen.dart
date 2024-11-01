import 'package:flutter/material.dart';
import 'package:tisha_app/screens/auth/auth_login_screen.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
import 'package:tisha_app/theme/spaces.dart';

class WelcomeScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const WelcomeScreen(),
    );
  }

  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "GovFarmInputTracker",
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              CustomSpaces.verticalSpace(height: 30),
              CustomButton(
                label: "Get Started",
                onPressed: () {
                  Navigator.push(context, AuthLoginScreen.route());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
