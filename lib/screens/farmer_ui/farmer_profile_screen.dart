import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/logic/auth_bloc/authentication_bloc.dart';
import 'package:tisha_app/logic/farmer_input_bloc/farmer_input_bloc.dart';
import 'package:tisha_app/logic/feedback/feedback_bloc.dart';
import 'package:tisha_app/logic/input_bloc/input_bloc.dart';
import 'package:tisha_app/logic/user_bloc/user_bloc.dart';
import 'package:tisha_app/screens/farmer_ui/input_notifications_screen.dart';
import 'package:tisha_app/screens/farmer_ui/user_applications_screen.dart';
import 'package:tisha_app/screens/farmer_ui/user_details_screen.dart';
import 'package:tisha_app/screens/farmer_ui/user_inputs_screen.dart';
import 'package:tisha_app/screens/feedback_forum_screen.dart';
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
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        UserDetailsScreen.route(),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_circle_rounded,
                          color: CustomColors.kIconColor,
                          size: 80,
                        ),
                        CustomSpaces.verticalSpace(height: 15),
                        Text(
                          "${loggedUser.name} ${loggedUser.surname}",
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: CustomColors.kBoldTextColor,
                                  ),
                        ),
                        CustomSpaces.verticalSpace(),
                        Text(
                          loggedUser.email,
                          style: Theme.of(context).textTheme.bodySmall,
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
                  ),
                  CustomSpaces.verticalSpace(height: 30),
                  BlocBuilder<InputBloc, InputState>(
                    buildWhen: (previous, current) =>
                        previous != current && current is LoadedInputs,
                    builder: (context, state) {
                      if (state is LoadedInputs) {
                        return MenuItem(
                          title: "Input Notifications",
                          subTitle: "${state.inputs.length} added inputs",
                          icon: Icons.notifications,
                          onTap: () {
                            Navigator.push(
                                context,
                                InputNotificationsScreen.route(
                                    userId: loggedUser.id));
                          },
                        );
                      }

                      if (state is InputStateLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return CustomButton(
                        label: "Reload",
                        onPressed: () {
                          context.read<InputBloc>().add(LoadInputs());
                        },
                      );
                    },
                  ),
                  MenuItem(
                    title: "My Applications",
                    subTitle: "${loggedUser.applications.length} applications",
                    icon: Icons.notes,
                    onTap: () {
                      Navigator.push(
                        context,
                        InputApplicationsScreen.route(
                          farmer: loggedUser,
                          applications: loggedUser.applications,
                        ),
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
                  BlocBuilder<FeedbackBloc, FeedbackState>(
                    buildWhen: (previous, current) =>
                        previous != current && current is LoadedFeedbacks,
                    builder: (context, state) {
                      if (state is LoadedFeedbacks) {
                        return MenuItem(
                          title: "Farmer's Forum",
                          subTitle: "${state.feedbacks.length} posts",
                          icon: Icons.forum,
                          onTap: () {
                            Navigator.push(
                                context, FeedbackForumScreen.route());
                          },
                        );
                      }

                      if (state is FeedbackStateLoading) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      return CustomButton(
                        label: "Reload",
                        onPressed: () {
                          context.read<FeedbackBloc>().add(LoadFeedbacks());
                        },
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
