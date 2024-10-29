import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/logic/location_bloc/location_bloc.dart';
import 'package:tisha_app/screens/admin_ui/add_input_screen.dart';
import 'package:tisha_app/screens/admin_ui/add_user_screen.dart';
import 'package:tisha_app/screens/admin_ui/input_report_screen.dart';
import 'package:tisha_app/screens/admin_ui/inputs_screen.dart';
import 'package:tisha_app/screens/admin_ui/locations_screen.dart';
import 'package:tisha_app/screens/admin_ui/users_screen.dart';
import 'package:tisha_app/screens/profile_screen.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
import 'package:tisha_app/screens/widgets/menu_item.dart';
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
              title: "Add users",
              subTitle: "add new",
              icon: Icons.person_add_alt,
              onTap: () {
                Navigator.push(context, AddUserScreen.route());
              },
            ),
            MenuItem(
              title: "All users",
              subTitle: "users",
              icon: Icons.people,
              onTap: () {
                Navigator.push(context, UsersScreen.route());
              },
            ),
            MenuItem(
              title: "Input registration",
              subTitle: "register new",
              icon: Icons.input,
              onTap: () {
                Navigator.push(context, AddInputScreen.route());
              },
            ),
            MenuItem(
              title: "Reports",
              subTitle: "input reports",
              icon: Icons.report,
              onTap: () {
                Navigator.push(context, InputReportScreen.route());
              },
            ),
            MenuItem(
              title: "Tracker",
              subTitle: "input tracker",
              icon: Icons.track_changes,
              onTap: () {
                Navigator.push(context, InputsScreen.route());
              },
            ),
            // BlocBuilder<FarmerBloc, FarmerState>(
            //   buildWhen: (previous, current) =>
            //       previous != current && current is LoadedFarmers,
            //   builder: (context, state) {
            //     if (state is LoadedFarmers) {
            //       return MenuItem(
            //         title: "Registered Farmers",
            //         subTitle: "${state.farmers.length} farmers",
            //         icon: Icons.people,
            //         onTap: () {
            //           Navigator.push(context, FarmersScreen.route());
            //         },
            //       );
            //     }

            //     if (state is FarmerStateLoading) {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     }
            //     return CustomButton(
            //       label: "Reload",
            //       onPressed: () {
            //         context.read<FarmerBloc>().add(LoadFarmers());
            //       },
            //     );
            //   },
            // ),
            // BlocBuilder<InputBloc, InputState>(
            //   buildWhen: (previous, current) =>
            //       previous != current && current is LoadedInputs,
            //   builder: (context, state) {
            //     if (state is LoadedInputs) {
            //       return MenuItem(
            //         title: "Registered Inputs",
            //         subTitle: "${state.inputs.length} inputs",
            //         icon: Icons.water_drop,
            //         onTap: () {
            //           Navigator.push(context, InputsScreen.route());
            //         },
            //       );
            //     }

            //     if (state is InputStateLoading) {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     }
            //     return CustomButton(
            //       label: "Reload",
            //       onPressed: () {
            //         context.read<InputBloc>().add(LoadInputs());
            //       },
            //     );
            //   },
            // ),
            // BlocBuilder<FarmerApplicationBloc, FarmerApplicationState>(
            //   buildWhen: (previous, current) =>
            //       previous != current && current is LoadedApplications,
            //   builder: (context, state) {
            //     if (state is LoadedApplications) {
            //       return MenuItem(
            //         title: "Input Applications",
            //         subTitle: "${state.applications.length} applications",
            //         icon: Icons.notes,
            //         onTap: () {
            //           Navigator.push(context, InputApplicationsScreen.route());
            //         },
            //       );
            //     }

            //     if (state is FarmerApplicationStateLoading) {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     }
            //     return CustomButton(
            //       label: "Reload",
            //       onPressed: () {
            //         context
            //             .read<FarmerApplicationBloc>()
            //             .add(LoadApplications());
            //       },
            //     );
            //   },
            // ),
            BlocBuilder<LocationBloc, LocationState>(
              buildWhen: (previous, current) =>
                  previous != current && current is LoadedLocations,
              builder: (context, state) {
                if (state is LoadedLocations) {
                  return MenuItem(
                    title: "Locations",
                    subTitle: "${state.locations.length} locations",
                    icon: Icons.location_city,
                    onTap: () {
                      Navigator.push(context, LocationsScreen.route());
                    },
                  );
                }

                if (state is LocationStateLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return CustomButton(
                  label: "Reload",
                  onPressed: () {
                    context.read<LocationBloc>().add(LoadLocations());
                  },
                );
              },
            ),
            // BlocBuilder<FeedbackBloc, FeedbackState>(
            //   buildWhen: (previous, current) =>
            //       previous != current && current is LoadedFeedbacks,
            //   builder: (context, state) {
            //     if (state is LoadedFeedbacks) {
            //       return MenuItem(
            //         title: "Farmer's Forum",
            //         subTitle: "${state.feedbacks.length} posts",
            //         icon: Icons.forum,
            //         onTap: () {
            //           Navigator.push(context, FeedbackForumScreen.route());
            //         },
            //       );
            //     }

            //     if (state is FeedbackStateLoading) {
            //       return const Center(
            //         child: CircularProgressIndicator(),
            //       );
            //     }
            //     return CustomButton(
            //       label: "Reload",
            //       onPressed: () {
            //         context.read<FeedbackBloc>().add(LoadFeedbacks());
            //       },
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }
}
