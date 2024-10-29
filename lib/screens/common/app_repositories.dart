import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/data/repositories/application/application_provider.dart';
import 'package:tisha_app/data/repositories/application/application_repository.dart';
import 'package:tisha_app/data/repositories/authentication/authentication_provider.dart';
import 'package:tisha_app/data/repositories/authentication/authentication_repository.dart';
import 'package:tisha_app/data/repositories/feedback/feedback_provider.dart';
import 'package:tisha_app/data/repositories/feedback/feedback_repository.dart';
import 'package:tisha_app/data/repositories/location/location_provider.dart';
import 'package:tisha_app/data/repositories/location/location_repository.dart';
import 'package:tisha_app/data/repositories/input/input_provider.dart';
import 'package:tisha_app/data/repositories/input/input_repository.dart';
import 'package:tisha_app/data/repositories/farmer/farmer_provider.dart';
import 'package:tisha_app/data/repositories/farmer/farmer_repository.dart';
import 'package:tisha_app/data/repositories/person/person_provider.dart';
import 'package:tisha_app/data/repositories/person/person_repository.dart';
import 'package:tisha_app/data/repositories/user/user_provider.dart';
import 'package:tisha_app/data/repositories/user/user_repository.dart';

class AppRepositories extends StatelessWidget {
  final Widget appBlocs;
  const AppRepositories({
    Key? key,
    required this.appBlocs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthenticationRepository(
            authenticationProvider: AuthenticationProvider(),
          ),
        ),
        RepositoryProvider(
          create: (context) => UserRepository(
            userProvider: UserProvider(),
          ),
        ),
        RepositoryProvider(
          create: (context) => PersonRepository(
            personProvider: PersonProvider(),
          ),
        ),
        RepositoryProvider(
          create: (context) => LocationRepository(
            locationProvider: LocationProvider(),
          ),
        ),
        RepositoryProvider(
          create: (context) => InputRepository(
            inputProvider: InputProvider(),
          ),
        ),
        RepositoryProvider(
          create: (context) => FarmerRepository(
            farmerProvider: FarmerProvider(),
          ),
        ),
        RepositoryProvider(
          create: (context) => ApplicationRepository(
            applicationProvider: ApplicationProvider(),
          ),
        ),
        RepositoryProvider(
          create: (context) => FeedbackRepository(
            feedbackProvider: FeedbackProvider(),
          ),
        ),
      ],
      child: appBlocs,
    );
  }
}
