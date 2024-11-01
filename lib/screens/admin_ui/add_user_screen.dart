import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/data/models/enums.dart';
import 'package:tisha_app/data/models/location.dart';
import 'package:tisha_app/logic/farmer_bloc/farmer_bloc.dart';
import 'package:tisha_app/logic/location_bloc/location_bloc.dart';
import 'package:tisha_app/logic/person_bloc%20/person_bloc.dart';
import 'package:tisha_app/screens/admin_ui/users_screen.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
import 'package:tisha_app/screens/widgets/custom_dropdown.dart';
import 'package:tisha_app/screens/widgets/custom_text_field.dart';
import 'package:tisha_app/screens/widgets/searchable_dropdown.dart';
import 'package:tisha_app/theme/colors.dart';
import 'package:tisha_app/theme/spaces.dart';

class AddUserScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const AddUserScreen(),
    );
  }

  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  late Location? selectedLocation;
  List<Location> locations = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formOneKey = GlobalKey<FormState>();

  final TextEditingController _firstnameController = TextEditingController();
  final TextEditingController _lastnameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _nationalIdController = TextEditingController();

  //farmner details
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _livestockNumberController =
      TextEditingController();
  final TextEditingController _coordinatesController = TextEditingController();
  String? selectedFarmerType;
  String? selectedOwnership;
  String? selectedCropType;
  String? selectedLivestock;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String? selectedGender;
  String? selectedRole;

  DateTime? selectedDate;

  int _activeCurrentStep = 0;

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

  List<Step> stepList() => [
        // This is step1 which is called Account.
        // Here we will fill our personal details
        Step(
          state:
              _activeCurrentStep <= 0 ? StepState.editing : StepState.complete,
          isActive: _activeCurrentStep >= 0,
          title: Text(
            "User Details",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: CustomColors.kBoldTextColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          content: Form(
            key: _formOneKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextField(
                  label: "First name",
                  controller: _firstnameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Firstname is required';
                    }

                    // if (value.length < 2) {
                    //   return "Firstname should be atleast 3 characters";
                    // }

                    return null;
                  },
                ),
                CustomSpaces.verticalSpace(height: 15),
                CustomTextField(
                  label: "Surname",
                  controller: _lastnameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Surname is required';
                    }

                    // if (value.length < 2) {
                    //   return "Surname should be atleast 3 characters";
                    // }

                    return null;
                  },
                ),
                CustomSpaces.verticalSpace(height: 15),
                CustomTextField(
                  label: "National ID",
                  controller: _nationalIdController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'National ID is required';
                    }

                    // if (value.length < 8) {
                    //   return "National ID should be atleast 8 characters";
                    // }

                    final bool valid = RegExp(
                            "(^\\d{2}) (\\d{4,7}) ([A-Z-a-z]{1} (\\d{2}\$))|(^\\d{2})-(\\d{4,7})-([A-Z-a-z]{1}-(\\d{2}\$))")
                        .hasMatch(value);
                    if (!valid) {
                      return "Please enter a valid National ID";
                    }

                    return null;
                  },
                ),
                CustomSpaces.verticalSpace(height: 30),
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
                selectedDate == null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          "D.O.B is required",
                          style:
                              Theme.of(context).textTheme.bodySmall!.copyWith(
                                    color: CustomColors.kWarningColor,
                                  ),
                        ),
                      )
                    : const SizedBox.shrink(),
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
                selectedGender == null
                    ? Text(
                        "Gender is required",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: CustomColors.kWarningColor,
                            ),
                      )
                    : const SizedBox.shrink(),
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
                CustomSpaces.verticalSpace(),
                CustomDropdown(
                  items: Role.values.map((value) => value.name).toList(),
                  hintText: "Role",
                  selectedItem: selectedRole,
                  onChanged: (value) {
                    setState(() {
                      selectedRole = value!;
                    });
                  },
                ),
                selectedRole == null
                    ? Text(
                        "Role is required",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: CustomColors.kWarningColor,
                            ),
                      )
                    : const SizedBox.shrink(),
                CustomSpaces.verticalSpace(),
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
                                    labelText: "User location",
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
                selectedLocation == null
                    ? Text(
                        "Location is required",
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                              color: CustomColors.kWarningColor,
                            ),
                      )
                    : const SizedBox.shrink(),

                //farmer details
                selectedRole != null && selectedRole == "FARMER"
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomSpaces.verticalSpace(height: 30),
                          Text(
                            "Farm Details",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
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
                            items: OwnerShip.values
                                .map((value) => value.name)
                                .toList(),
                            hintText: "Ownership",
                            selectedItem: selectedOwnership,
                            onChanged: (value) {
                              setState(() {
                                selectedOwnership = value!;
                              });
                            },
                          ),
                          selectedOwnership == null
                              ? Text(
                                  "Ownership is required",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: CustomColors.kWarningColor,
                                      ),
                                )
                              : const SizedBox.shrink(),
                          CustomSpaces.verticalSpace(),
                          CustomDropdown(
                            items: FarmerType.values
                                .map((value) => value.name)
                                .toList(),
                            hintText: "Farmer Type",
                            selectedItem: selectedFarmerType,
                            onChanged: (value) {
                              setState(() {
                                selectedFarmerType = value;
                              });
                            },
                          ),
                          selectedFarmerType == null
                              ? Text(
                                  "Farmer Type is required",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall!
                                      .copyWith(
                                        color: CustomColors.kWarningColor,
                                      ),
                                )
                              : const SizedBox.shrink(),
                          CustomSpaces.verticalSpace(),
                          CustomDropdown(
                            items: CropType.values
                                .map((value) => value.name)
                                .toList(),
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
                            items: LiveStockType.values
                                .map((value) => value.name)
                                .toList(),
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
                          CustomTextField(
                            label: "Farm Coordinates",
                            controller: _coordinatesController,
                          ),
                        ],
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),

        Step(
          state: StepState.complete,
          isActive: _activeCurrentStep >= 2,
          title: Text(
            "Login Details",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: CustomColors.kBoldTextColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          content: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomTextField(
                  label: "Email Address",
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }

                    final bool emailValid = RegExp(
                            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                        .hasMatch(value);
                    if (!emailValid) {
                      return "Please enter a valid email";
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

                    if (value.length < 6) {
                      return "Password should be atleast 6 characters";
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
                BlocBuilder<PersonBloc, PersonState>(
                  builder: (context, state) {
                    if (state is PersonStateLoading) {
                      return const CustomButton();
                    }
                    return CustomButton(
                      label: "Submit",
                      onPressed: () {
                        if (_formKey.currentState!.validate() &&
                            _formOneKey.currentState!.validate()) {
                          context.read<PersonBloc>().add(
                                AddPersonEvent(
                                  firstname: _firstnameController.text.trim(),
                                  lastname: _lastnameController.text.trim(),
                                  dob: selectedDate,
                                  gender: selectedGender,
                                  role: selectedRole,
                                  phone: _phoneNumberController.text.trim(),
                                  address: _addressController.text.trim(),
                                  nationalId: _nationalIdController.text.trim(),
                                  //farmer details
                                  farmSize: _sizeController.text.trim().isEmpty
                                      ? null
                                      : double.parse(
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
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        )
      ];

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
          "New User",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: CustomColors.kWhiteTextColor,
              ),
        ),
      ),
      body: BlocListener<PersonBloc, PersonState>(
        listener: (context, state) {
          if (state is PersonCreated) {
            Navigator.pushAndRemoveUntil(
              context,
              UsersScreen.route(),
              (route) => false,
            );
          }
        },
        child: Stepper(
          type: StepperType.vertical,
          currentStep: _activeCurrentStep,
          steps: stepList(),
          controlsBuilder: (BuildContext ctx, ControlsDetails dtl) {
            return _activeCurrentStep == 1
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            onPressed: dtl.onStepContinue,
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  CustomColors.kPrimaryColor),
                            ),
                            child: Text(
                              "CONTINUE",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 12,
                                    color: CustomColors.kWhiteTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                        CustomSpaces.horizontalSpace(),
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _activeCurrentStep == 0
                                ? navigateBack
                                : dtl.onStepCancel,
                            style: ButtonStyle(
                              backgroundColor: MaterialStatePropertyAll(
                                  CustomColors.kWarningColor),
                            ),
                            child: Text(
                              "CANCEL",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(
                                    fontSize: 12,
                                    color: CustomColors.kWhiteTextColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          },
          // onStepContinue takes us to the next step
          onStepContinue: () {
            if (_activeCurrentStep == 0 &&
                _formOneKey.currentState!.validate() &&
                selectedDate != null &&
                selectedGender != null &&
                selectedRole != null) {
              setState(() {
                _activeCurrentStep += 1;
              });
            }
          },

          // onStepCancel takes us to the previous step
          onStepCancel: () {
            if (_activeCurrentStep == 0) {
              return;
            }

            setState(() {
              _activeCurrentStep -= 1;
            });
          },

          // onStepTap allows to directly click on the particular step we want
          onStepTapped: (int index) {
            setState(() {
              _activeCurrentStep = index;
            });
          },
        ),
      ),
    );
  }

  void navigateBack() {
    Navigator.pop(context);
  }
}
