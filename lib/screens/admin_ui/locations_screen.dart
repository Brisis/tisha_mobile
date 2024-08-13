import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/logic/location_bloc/location_bloc.dart';
import 'package:tisha_app/screens/admin_ui/add_location_screen.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
import 'package:tisha_app/theme/colors.dart';

class LocationsScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const LocationsScreen(),
    );
  }

  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<LocationBloc>().add(LoadLocations());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.kWhiteTextColor),
        backgroundColor: CustomColors.kPrimaryColor,
        elevation: 1.0,
        title: Text(
          "Registered Locations",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: CustomColors.kWhiteTextColor,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            if (state is LoadedLocations) {
              final locations = state.locations.reversed.toList();

              return locations.isNotEmpty
                  ? ListView.builder(
                      itemCount: locations.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: LocationItem(
                            name: locations[index].name,
                            district: locations[index].city,
                            onTap: () {},
                          ),
                        );
                      })
                  : Center(
                      child: Text(
                        "0 Found",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
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
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.kPrimaryColor,
        onPressed: () {
          Navigator.push(context, AddLocationScreen.route());
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

class LocationItem extends StatelessWidget {
  final String name;
  final String district;
  final Function()? onTap;
  const LocationItem({
    super.key,
    required this.name,
    required this.district,
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
          district,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ),
    );
  }
}
