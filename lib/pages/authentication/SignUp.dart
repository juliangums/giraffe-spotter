import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/blocs/authentication/AuthenticationBloc.dart';
import 'package:giraffe_spotter/blocs/authentication/AuthenticationEvent.dart';
import 'package:giraffe_spotter/blocs/authentication/sign_up/Bloc.dart';
import 'package:giraffe_spotter/blocs/exceptions/ExceptionsBloc.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/inputs/widgets/CheckBoxInput.dart';
import 'package:giraffe_spotter/pages/authentication/widgets/RegisterInputs.dart';
import 'package:giraffe_spotter/pages/home/pages/HomePage.dart';
import 'package:giraffe_spotter/repositories/AuthenticationRepository.dart';
import 'package:giraffe_spotter/widgets/ArrowBackButton.dart';
import 'package:giraffe_spotter/widgets/GradientSnackBar.dart';
import 'package:giraffe_spotter/widgets/LargeButton.dart';

import 'Login.dart';

class SignUp extends StatelessWidget {
  final bool popping;

  SignUp({this.popping = false});

  AuthenticationRepository _authenticationRepository = AuthenticationRepository();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Palette.primaryColor,
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => SignUpCubit(_authenticationRepository)),
            BlocProvider(create: (context) => ExceptionsBloc())
          ],
          child: BlocListener<SignUpCubit, SignUpState>(
            listenWhen: (prev, current) => prev.status != current.status,
            listener: listenForStateChanges,
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                reverse: true,
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          color: Palette.bannerColor,
                          width: width,
                          constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.45),
                          child: Stack (
                            children: [
                              Positioned(
                                  top: 42,
                                  left: 30,
                                  child: Transform.scale(
                                    scale: 1.45,
                                    child: Container(height: 350, child: Image.asset(Assets.authBanner)),
                                  )),
                              Positioned(
                                bottom: 60,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.only(left: 26.5),
                                      child: Text('Glad you’re\njoining us', style: Styles.bannerTitle.copyWith(height: 1.29)),
                                    ),
                                    SizedBox(height: 12),
                                    Container(
                                      padding: EdgeInsets.only(left: 26),
                                      child: Text('Welcome', style: Styles.bannerSubTitle),
                                    )
                                  ],
                                ),
                              ),
                              Positioned(top: 50, left: 2, child: ArrowBackButton(home: true))
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [Palette.bannerColor, Palette.primaryColor],
                                  stops: [0.1, 0.35])),
                          child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)),
                                  color: Palette.containerColor),
                              width: width,
                              child: FormInput()),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Listener
  void listenForStateChanges(BuildContext context, SignUpState state) {
    switch (state.status) {
      case FormzStatus.submissionFailure:
        if (context.read<SignUpCubit>().errorMessage != '') {
          GradientSnackBar.showErrorMessage(context, context.read<SignUpCubit>().errorMessage);
        }
        break;
      case FormzStatus.submissionSuccess:
        context.read<AuthenticationBloc>().add(AuthenticationUserChanged(state.user));
        locator!<AppRoute>().navigateAndRemoveUntil(HomePage());
        break;
      default:
        break;
    }
  }
}

class FormInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RegisterInputs(),
          SizedBox(height: 5),
          RegisterChecker<SignUpCubit, SignUpState>(),
          SizedBox(height: 28),
          Padding(
            padding: const EdgeInsets.only(right: 24, left: 25),
            child: Container(
              child: BlocBuilder<SignUpCubit, SignUpState>(
                builder: (context, state) => LargeButtonReplacement(
                  title: "Sign Up",
                  loading: (state.status.isSubmissionInProgress) ? true : false,
                  active: (state.password.valid && state.email.valid && state.fullName.valid && state.acceptTerms.valid) ? true : false,
                  onTap: () => (state.password.valid && state.email.valid && state.fullName.valid && state.acceptTerms.valid)
                      ? context.read<SignUpCubit>().signUp()
                      : {},
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          InkWell(
            key: Key('signIn'),
            onTap: () => locator!<AppRoute>().navigateAndRemoveUntil(Login()),
            child: RichText(
              text: TextSpan(
                text: 'Already have an account? ',
                style: Styles.labelTextFormField,
                children: <TextSpan>[
                  TextSpan(text: 'Sign In', style: Styles.spanText.copyWith(fontFamily: 'Poppins-SemiBold')),
                ],
              ),
            ),
          ),
          SizedBox(height: 20)
        ],
      ),
    );
  }
}
