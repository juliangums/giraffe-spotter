import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/blocs/authentication/AuthenticationBloc.dart';
import 'package:giraffe_spotter/blocs/authentication/AuthenticationState.dart';
import 'package:giraffe_spotter/blocs/dynamic_links/DynamicCubit.dart';
import 'package:giraffe_spotter/blocs/giraffe_profile/GiraffeProfileCubit.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Constants.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/config/Theme.dart';
import 'package:giraffe_spotter/pages/authentication/Login.dart';
import 'package:giraffe_spotter/pages/authentication/ResetPassword.dart';
import 'package:giraffe_spotter/pages/home/pages/GiraffeProfile.dart';
import 'package:giraffe_spotter/pages/home/pages/HomePage.dart';
import 'package:giraffe_spotter/pages/onBoarding/OnBoardingPage.dart';
import 'package:giraffe_spotter/repositories/GiraffeProfileRepository.dart';
import 'package:giraffe_spotter/utils/SharedObjects.dart';

import 'network/NoNetworkPage.dart';
import 'onBoarding/SplashScreen.dart';

class AppView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        return BlocProvider(
          create: (context) => GiraffeProfileCubit(repository: GiraffeProfileRepository()),
          child: BlocListener<DynamicCubit, DynamicState>(
            listener: listenerDynamic,
            child: BlocListener<AuthenticationBloc, AuthenticationState>(listener: listenForAuthChanges, child: child),
          ),
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'Giraffe Spotter',
      navigatorKey: locator!<AppRoute>().navigatorKey,
      theme: Themes.primaryTheme,
      onGenerateRoute: (_) => SplashScreen.route(),
    );
  }

  void listenerDynamic(BuildContext context, DynamicState state) async {
    if (state.status == FormzStatus.submissionSuccess) {
      if (state.route == 'ResetPassword') {
        switch (context.read<AuthenticationBloc>().state.status) {
          case AuthenticationStatus.authenticated:
            break;
          case AuthenticationStatus.unauthenticated:
            bool isFirstRun = SharedObjects.prefs!.getBool(Constants.firstRun) ?? false;
            if (isFirstRun == false) {
              await SharedObjects.prefs!.setBool(Constants.firstRun, true);
              locator!<AppRoute>().navigateAndRemoveUntil(OnBoardingPage());
            } else {
              if (SharedObjects.prefs!.getString(Constants.reset) != '') {
                locator!<AppRoute>().navigateTo(ResetPassword());
              }
            }
            break;
          case AuthenticationStatus.no_internet:
            locator!<AppRoute>().navigateAndReplace(NoNetworkPage());
            break;
          case AuthenticationStatus.verified:
            // TODO: Handle this case.
            break;
          case AuthenticationStatus.completed:
            // TODO: Handle this case.
            break;
          case AuthenticationStatus.unknown:
            // TODO: Handle this case.
            break;
        }
      }
      if (state.route == 'GiraffeProfilePage') {
        switch (context.read<AuthenticationBloc>().state.status) {
          case AuthenticationStatus.authenticated:
            await context.read<GiraffeProfileCubit>().singleGiraffeData(state.data.toString());
            locator!<AppRoute>().navigateAndRemoveUntil(GiraffeProfilePage(
              giraffeData: context.read<GiraffeProfileCubit>().singleData,
              home: false,
            ));
            break;
          case AuthenticationStatus.unauthenticated:
            bool isFirstRun = SharedObjects.prefs!.getBool(Constants.firstRun) ?? false;
            if (isFirstRun == false) {
              await SharedObjects.prefs!.setBool(Constants.firstRun, true);
              locator!<AppRoute>().navigateAndRemoveUntil(OnBoardingPage());
            } else {
              locator!<AppRoute>().navigateAndRemoveUntil(Login());
            }
            break;
          case AuthenticationStatus.no_internet:
            locator!<AppRoute>().navigateAndReplace(NoNetworkPage());
            break;
          case AuthenticationStatus.verified:
            // TODO: Handle this case.
            break;
          case AuthenticationStatus.completed:
            // TODO: Handle this case.
            break;
          case AuthenticationStatus.unknown:
            // TODO: Handle this case.
            break;
        }
      }
    }
  }

  //listen for auth changes
  Future<void> listenForAuthChanges(BuildContext context, AuthenticationState state) async {
    switch (state.status) {
      case AuthenticationStatus.authenticated:
        if (context.read<DynamicCubit>().state.status.isSubmissionInProgress) {}
        locator!<AppRoute>().navigateAndRemoveUntil(HomePage());
        break;
      case AuthenticationStatus.unauthenticated:
        bool isFirstRun = SharedObjects.prefs!.getBool(Constants.firstRun) ?? false;
        if (isFirstRun == false) {
          await SharedObjects.prefs!.setBool(Constants.firstRun, true);
          locator!<AppRoute>().navigateAndRemoveUntil(OnBoardingPage());
        } else {
          locator!<AppRoute>().navigateAndRemoveUntil(Login());
        }
        break;
      case AuthenticationStatus.no_internet:
        locator!<AppRoute>().navigateAndReplace(NoNetworkPage());
        break;
      case AuthenticationStatus.verified:
        // TODO: Handle this case.
        break;
      case AuthenticationStatus.completed:
        // TODO: Handle this case.
        break;
      case AuthenticationStatus.unknown:
        // TODO: Handle this case.
        break;
    }
  }
}
