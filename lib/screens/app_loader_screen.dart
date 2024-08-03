import 'package:flutter/material.dart';

class AppLoaderScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const AppLoaderScreen(),
    );
  }

  const AppLoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Loading...",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ),
    );
  }
}
