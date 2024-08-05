import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/logic/auth_bloc/authentication_bloc.dart';
import 'package:tisha_app/logic/farmer_input_bloc/farmer_input_bloc.dart';
import 'package:tisha_app/logic/user_bloc/user_bloc.dart';
import 'package:tisha_app/screens/farmer_ui/user_details_screen.dart';
import 'package:tisha_app/screens/farmer_ui/user_inputs_screen.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
import 'package:tisha_app/screens/widgets/menu_item.dart';
import 'package:tisha_app/theme/colors.dart';
import 'package:tisha_app/theme/spaces.dart';

class FarmerProfileScreen extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const FarmerProfileScreen(),
    );
  }

  const FarmerProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.kWhiteTextColor),
        backgroundColor: CustomColors.kPrimaryColor,
        elevation: 1.0,
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: CustomColors.kWhiteTextColor,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<UserBloc, UserState>(
          buildWhen: (previous, current) =>
              previous != current && current is LoadedUser,
          builder: (context, state) {
            if (state is LoadedUser) {
              final loggedUser = state.user;
              return ListView(
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
                        loggedUser.email,
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
                            loggedUser.location?.name ?? "No Location",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      )
                    ],
                  ),
                  CustomSpaces.verticalSpace(height: 30),
                  MenuItem(
                    title: "My Details",
                    subTitle: loggedUser.name,
                    icon: Icons.person,
                    onTap: () {
                      Navigator.push(
                        context,
                        UserDetailsScreen.route(),
                      );
                    },
                  ),
                  MenuItem(
                    title: "My Inputs",
                    subTitle: "${loggedUser.inputs.length} inputs",
                    icon: Icons.water_drop,
                    onTap: () {
                      context.read<FarmerInputBloc>().add(
                            LoadFarmerInputs(userId: loggedUser.id),
                          );
                      Navigator.push(
                        context,
                        UserInputsScreen.route(userId: loggedUser.id),
                      );
                    },
                  ),
                ],
              );
            }

            if (state is UserStateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return CustomButton(
              label: "Reload",
              onPressed: () {
                context
                    .read<AuthenticationBloc>()
                    .add(AuthenticationEventInitialize());
              },
            );
          },
        ),
      ),
    );
  }
}
