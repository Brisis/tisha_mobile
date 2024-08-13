import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/data/models/enums.dart';
import 'package:tisha_app/data/models/location.dart';
import 'package:tisha_app/data/models/user.dart';
import 'package:tisha_app/logic/auth_bloc/authentication_bloc.dart';
import 'package:tisha_app/logic/location_bloc/location_bloc.dart';
import 'package:tisha_app/logic/user_bloc/user_bloc.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
import 'package:tisha_app/screens/widgets/custom_dropdown.dart';
import 'package:tisha_app/screens/widgets/custom_text_field.dart';
import 'package:tisha_app/screens/widgets/searchable_dropdown.dart';
import 'package:tisha_app/theme/colors.dart';
import 'package:tisha_app/theme/spaces.dart';

class UserDetailsScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const UserDetailsScreen(),
    );
  }

  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  late User loggedUser;
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
    loggedUser = context.read<UserBloc>().state.user!;
    selectedLocation = context
        .read<LocationBloc>()
        .state
        .locations
        .firstWhere((element) => element.id == loggedUser.locationId);
    selectedDate = loggedUser.dob;
    _nameController.text = loggedUser.name;
    _nameController.text = loggedUser.surname ?? "";
    if (loggedUser.farmSize != null) {
      _sizeController.text = loggedUser.farmSize.toString();
    }
    _coordinatesController.text = loggedUser.coordinates ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.kWhiteTextColor),
        backgroundColor: CustomColors.kPrimaryColor,
        elevation: 1.0,
        title: Text(
          "My Details",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: CustomColors.kWhiteTextColor,
              ),
        ),
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is LoadedUser) {
            setState(() {
              loggedUser = state.user;
            });
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: ListView(
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
                    BlocBuilder<AuthenticationBloc, AuthenticationState>(
                      builder: (context, state) {
                        if (state is AuthenticationStateLoading) {
                          return const CustomButton();
                        }
                        return CustomButton(
                          label: "Logout",
                          buttonColor: CustomColors.kWarningColor,
                          onPressed: () {
                            context
                                .read<AuthenticationBloc>()
                                .add(AuthenticationEventLogoutUser());
                          },
                        );
                      },
                    ),
                  ],
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
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserStateError) {
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
                BlocBuilder<UserBloc, UserState>(
                  builder: (context, state) {
                    if (state is UserStateLoading) {
                      return const CustomButton();
                    }
                    return CustomButton(
                      label: "Submit",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          if (selectedLocation != null) {
                            // context.read<UserBloc>().add(
                            //       AddFarmerEvent(
                            //         name: _nameController.text.trim(),
                            //         surname: _surnameController.text.trim(),
                            //         dob: selectedDate,
                            //         gender: selectedGender,
                            //         phone: _phoneNumberController.text.trim(),
                            //         address: _addressController.text.trim(),
                            //         nationalId:
                            //             _nationalIdController.text.trim(),
                            //         farmSize: double.parse(
                            //             _sizeController.text.trim()),
                            //         coordinates:
                            //             _coordinatesController.text.trim(),
                            //         locationId: selectedLocation!.id,
                            //         landOwnership: selectedOwnership,
                            //         farmerType: selectedFarmerType,
                            //         cropType: selectedCropType,
                            //         livestockType: selectedLivestock,
                            //         livestockNumber: _livestockNumberController
                            //                 .text
                            //                 .trim()
                            //                 .isNotEmpty
                            //             ? int.parse(_livestockNumberController
                            //                 .text
                            //                 .trim())
                            //             : null,
                            //         email: _emailController.text.trim(),
                            //         password: _passwordController.text.trim(),
                            //       ),
                            //     );
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
