import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/logic/farmer_bloc/farmer_bloc.dart';
import 'package:tisha_app/screens/admin_ui/add_farmer_screen.dart';
import 'package:tisha_app/screens/admin_ui/farmer_screen.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
import 'package:tisha_app/theme/colors.dart';

class FarmersScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const FarmersScreen(),
    );
  }

  const FarmersScreen({super.key});

  @override
  State<FarmersScreen> createState() => _FarmersScreenState();
}

class _FarmersScreenState extends State<FarmersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FarmerBloc>().add(LoadFarmers());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.kWhiteTextColor),
        backgroundColor: CustomColors.kPrimaryColor,
        elevation: 1.0,
        title: Text(
          "Registered Farmers",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: CustomColors.kWhiteTextColor,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<FarmerBloc, FarmerState>(
          buildWhen: (previous, current) =>
              previous != current && current is LoadedFarmers,
          builder: (context, state) {
            if (state is LoadedFarmers) {
              final farmers = state.farmers;
              return farmers.isNotEmpty
                  ? ListView.builder(
                      itemCount: farmers.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: UserItem(
                            name: farmers[index].name,
                            inputs: farmers[index].inputs.length,
                            onTap: () {
                              context.read<FarmerBloc>().add(
                                    LoadFarmer(id: farmers[index].id),
                                  );
                              Navigator.push(
                                context,
                                FarmerScreen.route(
                                  userId: farmers[index].id,
                                ),
                              );
                            },
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text(
                        "Not Found",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
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
                context.read<FarmerBloc>().add(LoadFarmers());
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.kPrimaryColor,
        onPressed: () {
          Navigator.push(context, AddFarmerScreen.route());
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

class UserItem extends StatelessWidget {
  final String name;
  final int inputs;
  final Function()? onTap;
  const UserItem({
    super.key,
    required this.name,
    required this.inputs,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(3.0),
      shape: OutlineInputBorder(
        borderSide: BorderSide(
          color: CustomColors.kBorderColor,
        ),
      ),
      onTap: onTap,
      leading: CircleAvatar(
        maxRadius: 40,
        backgroundColor: CustomColors.kContainerBackgroundColor,
        child: Icon(
          Icons.person,
          color: CustomColors.kIconColor,
        ),
      ),
      title: Text(
        name,
        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.bold,
            ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Text(
          "$inputs Inputs",
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
