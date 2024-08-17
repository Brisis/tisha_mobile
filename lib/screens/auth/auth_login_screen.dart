import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/logic/auth_bloc/authentication_bloc.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
import 'package:tisha_app/screens/widgets/custom_text_field.dart';
import 'package:tisha_app/theme/colors.dart';
import 'package:tisha_app/theme/spaces.dart';

class AuthLoginScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const AuthLoginScreen(),
    );
  }

  const AuthLoginScreen({super.key});

  @override
  State<AuthLoginScreen> createState() => _AuthLoginScreenState();
}

class _AuthLoginScreenState extends State<AuthLoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CustomSpaces.verticalSpace(height: 50),
              Text(
                "Login",
                style: Theme.of(context).textTheme.displayLarge,
                textAlign: TextAlign.center,
              ),
              CustomSpaces.verticalSpace(height: 15),
              CustomTextField(
                label: "Email Address",
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null) {
                    return "Email is required";
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
                obscureText: true,
                validator: (value) {
                  if (value == null) {
                    return "Password is required";
                  }
                  if (value.length < 6) {
                    return "Password should be atleast 6 characters";
                  }

                  return null;
                },
              ),
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is AuthenticationStateError) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 30.0),
                      child: Text(
                        state.authError!.dialogText,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
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
              BlocBuilder<AuthenticationBloc, AuthenticationState>(
                builder: (context, state) {
                  if (state is AuthenticationStateLoading) {
                    return const CustomButton();
                  }
                  return CustomButton(
                    label: "Login",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthenticationBloc>().add(
                              AuthenticationEventLoginUser(
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
      ),
    );
  }
}
