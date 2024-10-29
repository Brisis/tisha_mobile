import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/data/models/enums.dart';
import 'package:tisha_app/data/models/location.dart';
import 'package:tisha_app/data/models/user.dart';
import 'package:tisha_app/logic/input_bloc/input_bloc.dart';
import 'package:tisha_app/logic/location_bloc/location_bloc.dart';
import 'package:tisha_app/logic/user_bloc/user_bloc.dart';
import 'package:tisha_app/screens/admin_ui/inputs_screen.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
import 'package:tisha_app/screens/widgets/custom_dropdown.dart';
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
  final TextEditingController _barcodeController = TextEditingController();
  final TextEditingController _chassisNumberController =
      TextEditingController();
  final TextEditingController _engineTypeController = TextEditingController();
  final TextEditingController _numberPlateController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();

  String? selectedType;
  String? selectedScheme;

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
          if (state is InputCreated) {
            Navigator.pushAndRemoveUntil(
              context,
              InputsScreen.route(),
              (route) => false,
            );
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
                CustomSpaces.verticalSpace(),
                CustomDropdown(
                  items: InputScheme.values.map((value) => value.name).toList(),
                  hintText: "Input Scheme",
                  selectedItem: selectedScheme,
                  onChanged: (value) {
                    setState(() {
                      selectedScheme = value!;
                    });
                  },
                ),
                selectedScheme == null
                    ? Text(
                        "Scheme is required",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: CustomColors.kWarningColor,
                            ),
                      )
                    : const SizedBox.shrink(),
                // CustomSpaces.verticalSpace(),
                CustomDropdown(
                  items: InputType.values.map((value) => value.name).toList(),
                  hintText: "Type",
                  selectedItem: selectedType,
                  onChanged: (value) {
                    setState(() {
                      selectedType = value!;
                    });
                  },
                ),
                selectedType == null
                    ? Text(
                        "Type is required",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: CustomColors.kWarningColor,
                            ),
                      )
                    : const SizedBox.shrink(),
                // CustomSpaces.verticalSpace(),
                CustomTextField(
                  label: "Quantity",
                  keyboardType: TextInputType.number,
                  controller: _quantityController,
                ),
                CustomSpaces.verticalSpace(),
                CustomTextField(
                  label: "Unit",
                  controller: _quantityUnitController,
                ),
                CustomSpaces.verticalSpace(),
                CustomTextField(
                  label: "Barcode number",
                  controller: _barcodeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Barcode number is required';
                    }

                    return null;
                  },
                ),
                CustomSpaces.verticalSpace(),
                selectedType != null && selectedType == InputType.Tructor.name
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 15.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomTextField(
                              label: "Chassis number",
                              controller: _chassisNumberController,
                            ),
                            CustomSpaces.verticalSpace(),
                            CustomTextField(
                              label: "Engine type",
                              controller: _engineTypeController,
                            ),
                            CustomSpaces.verticalSpace(),
                            CustomTextField(
                              label: "Number plate",
                              controller: _numberPlateController,
                            ),
                            CustomSpaces.verticalSpace(),
                            CustomTextField(
                              label: "Color",
                              controller: _colorController,
                            ),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
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
                          if (selectedLocation != null &&
                              selectedType != null &&
                              selectedScheme != null) {
                            context.read<InputBloc>().add(
                                  AddInputEvent(
                                    name: _nameController.text.trim(),
                                    quantity: int.parse(
                                        _quantityController.text.trim()),
                                    unit: _quantityUnitController.text.trim(),
                                    type: selectedType!,
                                    scheme: selectedScheme!,
                                    barcode: _barcodeController.text.trim(),
                                    chassisNumber:
                                        _chassisNumberController.text.trim(),
                                    engineType:
                                        _engineTypeController.text.trim(),
                                    numberPlate:
                                        _numberPlateController.text.trim(),
                                    color: _colorController.text.trim(),
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
