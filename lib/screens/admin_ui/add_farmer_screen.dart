import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/data/models/enums.dart';
import 'package:tisha_app/data/models/location.dart';
import 'package:tisha_app/logic/farmer_bloc/farmer_bloc.dart';
import 'package:tisha_app/logic/location_bloc/location_bloc.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
import 'package:tisha_app/screens/widgets/custom_dropdown.dart';
import 'package:tisha_app/screens/widgets/custom_text_field.dart';
import 'package:tisha_app/screens/widgets/searchable_dropdown.dart';
import 'package:tisha_app/theme/colors.dart';
import 'package:tisha_app/theme/spaces.dart';

class AddFarmerScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const AddFarmerScreen(),
    );
  }

  const AddFarmerScreen({super.key});

  @override
  State<AddFarmerScreen> createState() => _AddFarmerScreenState();
}

class _AddFarmerScreenState extends State<AddFarmerScreen> {
  late Location? selectedLocation;
  List<Location> locations = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _surnameController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _livestockNumberController =
      TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nationalIdController = TextEditingController();

  final TextEditingController _coordinatesController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? selectedFarmerType;
  String? selectedOwnership;
  String? selectedCropType;
  String? selectedLivestock;
  String? selectedGender;

  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1930),
        lastDate: DateTime(2030));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    super.initState();
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
          "New Farmer",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: CustomColors.kWhiteTextColor,
              ),
        ),
      ),
      body: BlocListener<FarmerBloc, FarmerState>(
        listener: (context, state) {
          if (state is LoadedFarmers) {
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
                  "Farmer Details",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: CustomColors.kBoldTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                CustomSpaces.verticalSpace(height: 15),
                CustomTextField(
                  label: "First name",
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Firstname is required';
                    }

                    return null;
                  },
                ),
                CustomSpaces.verticalSpace(height: 15),
                CustomTextField(
                  label: "Surname",
                  controller: _surnameController,
                ),
                CustomSpaces.verticalSpace(height: 15),
                CustomTextField(
                  label: "National ID",
                  controller: _nationalIdController,
                ),
                CustomSpaces.verticalSpace(height: 15),
                ListTile(
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: CustomColors.kBorderColor,
                    ),
                  ),
                  onTap: () => _selectDate(context),
                  title: Text(
                    "Date of Birth",
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      selectedDate != null
                          ? "${selectedDate!.toLocal()}".split(' ')[0]
                          : "Select Date",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  leading: Icon(
                    Icons.date_range,
                    color: CustomColors.kIconColor,
                  ),
                ),
                CustomSpaces.verticalSpace(),
                CustomDropdown(
                  items: Gender.values.map((value) => value.name).toList(),
                  hintText: "Gender",
                  selectedItem: selectedGender,
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value!;
                    });
                  },
                ),
                CustomSpaces.verticalSpace(),
                CustomTextField(
                  label: "Phone number",
                  keyboardType: TextInputType.phone,
                  controller: _phoneNumberController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Phone number is required';
                    }

                    return null;
                  },
                ),
                CustomSpaces.verticalSpace(height: 15),
                CustomTextField(
                  label: "Physical Address",
                  keyboardType: TextInputType.streetAddress,
                  controller: _addressController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Address is required';
                    }

                    return null;
                  },
                ),
                CustomSpaces.verticalSpace(height: 30),
                Text(
                  "Farm Details",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: CustomColors.kBoldTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                CustomSpaces.verticalSpace(),
                CustomTextField(
                  label: "Farm size (h.a)",
                  keyboardType: TextInputType.number,
                  controller: _sizeController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Farm size is required';
                    }

                    return null;
                  },
                ),
                CustomSpaces.verticalSpace(),
                CustomDropdown(
                  items: OwnerShip.values.map((value) => value.name).toList(),
                  hintText: "Ownership",
                  selectedItem: selectedOwnership,
                  onChanged: (value) {
                    setState(() {
                      selectedOwnership = value!;
                    });
                  },
                ),
                CustomSpaces.verticalSpace(),
                CustomDropdown(
                  items: FarmerType.values.map((value) => value.name).toList(),
                  hintText: "Farmer Type",
                  selectedItem: selectedFarmerType,
                  onChanged: (value) {
                    setState(() {
                      selectedFarmerType = value;
                    });
                  },
                ),
                CustomSpaces.verticalSpace(),
                CustomDropdown(
                  items: CropType.values.map((value) => value.name).toList(),
                  hintText: "Crop Type",
                  selectedItem: selectedCropType,
                  onChanged: (value) {
                    setState(() {
                      selectedCropType = value!;
                    });
                  },
                ),
                CustomSpaces.verticalSpace(),
                CustomDropdown(
                  items:
                      LiveStockType.values.map((value) => value.name).toList(),
                  hintText: "Livestock Type",
                  selectedItem: selectedLivestock,
                  onChanged: (value) {
                    setState(() {
                      selectedLivestock = value!;
                    });
                  },
                ),
                CustomSpaces.verticalSpace(height: 15),
                CustomTextField(
                  label: "Livestock Number",
                  keyboardType: TextInputType.number,
                  controller: _livestockNumberController,
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
                                    labelText: "Farm location",
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
                CustomSpaces.verticalSpace(height: 15),
                CustomTextField(
                  label: "Coordinates",
                  controller: _coordinatesController,
                ),
                CustomSpaces.verticalSpace(height: 30),
                Text(
                  "Login Details",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: CustomColors.kBoldTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                CustomSpaces.verticalSpace(height: 15),
                CustomTextField(
                  label: "Email Address",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }

                    return null;
                  },
                ),
                CustomSpaces.verticalSpace(height: 15),
                CustomTextField(
                  label: "Password",
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }

                    return null;
                  },
                ),
                BlocBuilder<FarmerBloc, FarmerState>(
                  builder: (context, state) {
                    if (state is FarmerStateError) {
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
                BlocBuilder<FarmerBloc, FarmerState>(
                  builder: (context, state) {
                    if (state is FarmerStateLoading) {
                      return const CustomButton();
                    }
                    return CustomButton(
                      label: "Submit",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (selectedLocation != null) {
                            context.read<FarmerBloc>().add(
                                  AddFarmerEvent(
                                    name: _nameController.text.trim(),
                                    surname: _surnameController.text.trim(),
                                    dob: selectedDate,
                                    gender: selectedGender,
                                    phone: _phoneNumberController.text.trim(),
                                    address: _addressController.text.trim(),
                                    nationalId:
                                        _nationalIdController.text.trim(),
                                    farmSize: double.parse(
                                        _sizeController.text.trim()),
                                    coordinates:
                                        _coordinatesController.text.trim(),
                                    locationId: selectedLocation!.id,
                                    landOwnership: selectedOwnership,
                                    farmerType: selectedFarmerType,
                                    cropType: selectedCropType,
                                    livestockType: selectedLivestock,
                                    livestockNumber: _livestockNumberController
                                            .text
                                            .trim()
                                            .isNotEmpty
                                        ? int.parse(_livestockNumberController
                                            .text
                                            .trim())
                                        : null,
                                    email: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
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
