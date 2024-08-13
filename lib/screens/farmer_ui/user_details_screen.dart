import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/data/models/user.dart';
import 'package:tisha_app/logic/auth_bloc/authentication_bloc.dart';
import 'package:tisha_app/logic/user_bloc/user_bloc.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _coordinatesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loggedUser = context.read<UserBloc>().state.user!;
    _nameController.text = loggedUser.name;
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
                  label: "Full name",
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }

                    return null;
                  },
                ),
                loggedUser.farmSize != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 15.0),
                        child: CustomTextField(
                          label: "Farm size (h.a)",
                          keyboardType: TextInputType.number,
                          controller: _sizeController,
                        ),
                      )
                    : const SizedBox.shrink(),
                CustomSpaces.verticalSpace(height: 15),
                SearchableDropDown(
                  items: [],
                  labelText: "Choose Location",
                ),
                CustomSpaces.verticalSpace(height: 15),
                CustomTextField(
                  label: "Coordinates",
                  controller: _coordinatesController,
                ),
                CustomSpaces.verticalSpace(height: 30),
                CustomButton(
                  label: "Save",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
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
