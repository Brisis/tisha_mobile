import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/data/repositories/application/application_repository.dart';
import 'package:tisha_app/data/repositories/farmer/farmer_repository.dart';
import 'package:tisha_app/data/repositories/feedback/feedback_repository.dart';
import 'package:tisha_app/data/repositories/input/input_repository.dart';
import 'package:tisha_app/data/repositories/location/location_repository.dart';
import 'package:tisha_app/data/repositories/user/user_repository.dart';
import 'package:tisha_app/logic/auth_bloc/authentication_bloc.dart';
import 'package:tisha_app/data/repositories/authentication/authentication_repository.dart';
import 'package:tisha_app/logic/farmer_application_bloc/farmer_application_bloc.dart';
import 'package:tisha_app/logic/farmer_input_bloc/farmer_input_bloc.dart';
import 'package:tisha_app/logic/feedback/feedback_bloc.dart';
import 'package:tisha_app/logic/input_bloc/input_bloc.dart';
import 'package:tisha_app/logic/location_bloc/location_bloc.dart';
import 'package:tisha_app/logic/farmer_bloc/farmer_bloc.dart';
import 'package:tisha_app/logic/user_bloc/user_bloc.dart';

class AppBlocs extends StatelessWidget {
  final Widget child;
  const AppBlocs({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthenticationBloc(
            authenticationRepository:
                RepositoryProvider.of<AuthenticationRepository>(context),
          )..add(AuthenticationEventInitialize()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => UserBloc(
            userRepository: RepositoryProvider.of<UserRepository>(context),
          ),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => LocationBloc(
            locationRepository:
                RepositoryProvider.of<LocationRepository>(context),
          )..add(LoadLocations()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => InputBloc(
            inputRepository: RepositoryProvider.of<InputRepository>(context),
          )..add(LoadInputs()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => FarmerInputBloc(
            inputRepository: RepositoryProvider.of<InputRepository>(context),
          ),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => FarmerBloc(
            farmerRepository: RepositoryProvider.of<FarmerRepository>(context),
          ),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => FarmerApplicationBloc(
            applicationRepository:
                RepositoryProvider.of<ApplicationRepository>(context),
          )..add(LoadApplications()),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => FeedbackBloc(
            feedbackRepository:
                RepositoryProvider.of<FeedbackRepository>(context),
          )..add(LoadFeedbacks()),
          lazy: false,
        ),
      ],
      child: child,
    );
  }
}
