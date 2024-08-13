import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/logic/farmer_bloc/farmer_bloc.dart';
import 'package:tisha_app/logic/farmer_input_bloc/farmer_input_bloc.dart';
import 'package:tisha_app/screens/admin_ui/farmer_applications_screen.dart';
import 'package:tisha_app/screens/admin_ui/farmer_details_screen.dart';
import 'package:tisha_app/screens/admin_ui/farmer_inputs_screen.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
import 'package:tisha_app/screens/widgets/menu_item.dart';
import 'package:tisha_app/theme/colors.dart';
import 'package:tisha_app/theme/spaces.dart';

class FarmerScreen extends StatefulWidget {
  static Route route({
    required String userId,
  }) {
    return MaterialPageRoute(
      builder: (context) => FarmerScreen(
        userId: userId,
      ),
    );
  }

  final String userId;
  const FarmerScreen({
    super.key,
    required this.userId,
  });

  @override
  State<FarmerScreen> createState() => _FarmerScreenState();
}

class _FarmerScreenState extends State<FarmerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.kWhiteTextColor),
        backgroundColor: CustomColors.kPrimaryColor,
        elevation: 1.0,
        title: Text(
          "Farmer",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: CustomColors.kWhiteTextColor,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<FarmerBloc, FarmerState>(
          buildWhen: (previous, current) =>
              previous != current && current is LoadedFarmer,
          builder: (context, state) {
            if (state is LoadedFarmer) {
              final farmer = state.farmer;
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
                        farmer.email,
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
                            farmer.location?.name ?? "No Location",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      )
                    ],
                  ),
                  CustomSpaces.verticalSpace(height: 30),
                  MenuItem(
                    title: "Farmer Details",
                    subTitle: "${farmer.name} ${farmer.surname}",
                    icon: Icons.person,
                    onTap: () {
                      Navigator.push(
                        context,
                        FarmerDetailsScreen.route(farmer: farmer),
                      );
                    },
                  ),
                  MenuItem(
                    title: "Input Applications",
                    subTitle: "${farmer.applications.length} applications",
                    icon: Icons.notes_rounded,
                    onTap: () {
                      context.read<FarmerInputBloc>().add(
                            LoadFarmerInputs(userId: farmer.id),
                          );
                      Navigator.push(
                        context,
                        FarmerApplicationsScreen.route(userId: farmer.id),
                      );
                    },
                  ),
                  MenuItem(
                    title: "Assigned Inputs",
                    subTitle: "${farmer.inputs.length} inputs",
                    icon: Icons.water_drop,
                    onTap: () {
                      context.read<FarmerInputBloc>().add(
                            LoadFarmerInputs(userId: farmer.id),
                          );
                      Navigator.push(
                        context,
                        FarmerInputsScreen.route(userId: farmer.id),
                      );
                    },
                  ),
                ],
              );
            }

            if (state is FarmerStateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return CustomButton(
              label: "Reload",
              onPressed: () {
                context.read<FarmerBloc>().add(LoadFarmer(id: widget.userId));
              },
            );
          },
        ),
      ),
    );
  }
}
