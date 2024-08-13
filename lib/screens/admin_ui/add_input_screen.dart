import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/data/models/location.dart';
import 'package:tisha_app/data/models/user.dart';
import 'package:tisha_app/logic/input_bloc/input_bloc.dart';
import 'package:tisha_app/logic/location_bloc/location_bloc.dart';
import 'package:tisha_app/logic/user_bloc/user_bloc.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
import 'package:tisha_app/screens/widgets/custom_text_field.dart';
import 'package:tisha_app/screens/widgets/searchable_dropdown.dart';
import 'package:tisha_app/theme/colors.dart';
import 'package:tisha_app/theme/spaces.dart';

class AddInputScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const AddInputScreen(),
    );
  }

  const AddInputScreen({super.key});

  @override
  State<AddInputScreen> createState() => _AddInputScreenState();
}

class _AddInputScreenState extends State<AddInputScreen> {
  late Location? selectedLocation;
  List<Location> locations = [];
  late User loggedUser;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _quantityUnitController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loggedUser = context.read<UserBloc>().state.user!;
    locations = context.read<LocationBloc>().state.locations;

    selectedLocation = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.kWhiteTextColor),
        backgroundColor: CustomColors.kPrimaryColor,
        elevation: 1.0,
        title: Text(
          "New Input",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: CustomColors.kWhiteTextColor,
              ),
        ),
      ),
      body: BlocListener<InputBloc, InputState>(
        listener: (context, state) {
          if (state is LoadedInputs) {
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  "Complete Form",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                CustomSpaces.verticalSpace(height: 15),
                CustomTextField(
                  label: "Input Name",
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }

                    return null;
                  },
                ),
                CustomSpaces.verticalSpace(height: 15),
                CustomTextField(
                  label: "Quantity",
                  keyboardType: TextInputType.number,
                  controller: _quantityController,
                ),
                CustomSpaces.verticalSpace(height: 15),
                CustomTextField(
                  label: "Quantity Unit",
                  controller: _quantityUnitController,
                ),
                CustomSpaces.verticalSpace(height: 15),
                Row(
                  children: [
                    Expanded(
                      child: BlocBuilder<LocationBloc, LocationState>(
                        builder: (context, state) {
                          if (state is LoadedLocations) {
                            final locations = state.locations;
                            List<String> convertedLocations = locations
                                .map((Location location) =>
                                    "${location.name} (${location.city})")
                                .toList();
                            String getInitial(Location chosen) {
                              return convertedLocations.firstWhere((location) =>
                                  location ==
                                  "${chosen.name} (${chosen.city})");
                            }

                            return locations.isNotEmpty
                                ? SearchableDropDown(
                                    initialText: selectedLocation != null
                                        ? getInitial(selectedLocation!)
                                        : null,
                                    labelText: "Targeted location",
                                    items: convertedLocations,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedLocation = locations.firstWhere(
                                            (location) =>
                                                "${location.name} (${location.city})" ==
                                                value);
                                      });
                                    },
                                  )
                                : const Text("No locations");
                          }

                          return Center(
                            child: SizedBox(
                              width: 25,
                              height: 25,
                              child: CircularProgressIndicator(
                                color: CustomColors.kPrimaryColor,
                                strokeWidth: 3,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                BlocBuilder<InputBloc, InputState>(
                  builder: (context, state) {
                    if (state is InputStateError) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Text(
                          state.message!.message!,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: CustomColors.kWarningColor,
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                ),
                CustomSpaces.verticalSpace(height: 30),
                BlocBuilder<InputBloc, InputState>(
                  builder: (context, state) {
                    if (state is InputStateLoading) {
                      return const CustomButton();
                    }
                    return CustomButton(
                      label: "Submit",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (selectedLocation != null) {
                            context.read<InputBloc>().add(
                                  AddInputEvent(
                                    name: _nameController.text.trim(),
                                    quantity: int.parse(
                                        _quantityController.text.trim()),
                                    unit: _quantityUnitController.text.trim(),
                                    locationId: selectedLocation!.id,
                                    userId: loggedUser.id,
                                  ),
                                );
                          }
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
