import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/logic/auth_bloc/authentication_bloc.dart';
import 'package:tisha_app/logic/farmer_bloc/farmer_bloc.dart';
import 'package:tisha_app/logic/input_bloc/input_bloc.dart';
import 'package:tisha_app/logic/location_bloc/location_bloc.dart';
// import 'package:tisha_app/logic/input_bloc/input_bloc.dart';
import 'package:tisha_app/logic/user_bloc/user_bloc.dart';
import 'package:tisha_app/screens/admin_ui/admin_home_screen.dart';
import 'package:tisha_app/screens/app_loader_screen.dart';
import 'package:tisha_app/screens/auth/auth_login_screen.dart';
import 'package:tisha_app/screens/common/app_blocs.dart';
import 'package:tisha_app/screens/common/app_repositories.dart';
import 'package:tisha_app/screens/welcome_screen.dart';
import 'package:tisha_app/theme/typography.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var config = const AppRepositories(
    appBlocs: AppBlocs(
      child: MainApp(),
    ),
  );

  runApp(config);
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState? get _navigator => navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'Tisha App',
      theme: ThemeData(
        fontFamily: "Proxima",
        textTheme: CustomTypography.textTheme,
      ),
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationStateIsInSplashPage) {
              _navigator!.pushAndRemoveUntil(
                AppLoaderScreen.route(),
                (route) => false,
              );
            }

            if (state is AuthenticationStateUserLoggedIn) {
              BlocProvider.of<UserBloc>(context).add(
                LoadUser(user: state.user),
              );

              BlocProvider.of<FarmerBloc>(context).add(LoadFarmers());
              BlocProvider.of<InputBloc>(context).add(LoadInputs());
              BlocProvider.of<LocationBloc>(context).add(LoadLocations());

              _navigator!.pushAndRemoveUntil(
                AdminHomeScreen.route(),
                (route) => false,
              );
            }

            if (state is AuthenticationStateUserLoggedOut) {
              _navigator!.pushAndRemoveUntil(
                AuthLoginScreen.route(),
                (route) => false,
              );
            }

            if (state is AuthenticationStateUserNotLoggedIn) {
              _navigator!.pushAndRemoveUntil(
                WelcomeScreen.route(),
                (route) => false,
              );
            }

            // if (state is AuthenticationStateError) {
            //   context
            //       .read<AuthenticationBloc>()
            //       .add(AuthenticationEventLogoutUser());
            // }

            // if (state is AuthenticationStateCodeSent) {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(
            //       content: Text(state.message),
            //       // . Check your messages
            //     ),
            //   );
            // }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => AppLoaderScreen.route(),
    );
  }
}
