import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/logic/auth_bloc/authentication_bloc.dart';
import 'package:tisha_app/theme/colors.dart';
import 'package:tisha_app/theme/spaces.dart';

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
      body: SafeArea(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticationStateError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "An error occured!",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: CustomColors.kWarningColor,
                          ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  CustomSpaces.verticalSpace(height: 30),
                  TextButton.icon(
                    onPressed: () {
                      context
                          .read<AuthenticationBloc>()
                          .add(AuthenticationEventLogoutUser());
                    },
                    icon: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        color: CustomColors.kBackgroundColor,
                        border: Border.all(color: CustomColors.kPrimaryColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      alignment: Alignment.center,
                      child: Icon(
                        Icons.rotate_left_sharp,
                        color: CustomColors.kPrimaryColor,
                        size: 25,
                      ),
                    ),
                    label: Text(
                      "Restart",
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: CustomColors.kPrimaryColor),
                    ),
                  ),
                ],
              );
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Loading...",
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
