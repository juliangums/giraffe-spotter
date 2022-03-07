import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/blocs/authentication/AuthenticationBloc.dart';
import 'package:giraffe_spotter/blocs/authentication/AuthenticationEvent.dart';
import 'package:giraffe_spotter/blocs/authentication/login/LoginCubit.dart';
import 'package:giraffe_spotter/blocs/authentication/login/LoginState.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Decorations.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/pages/authentication/ForgotPassword.dart';
import 'package:giraffe_spotter/pages/authentication/SignUp.dart';
import 'package:giraffe_spotter/pages/authentication/widgets/LoginInputs.dart';
import 'package:giraffe_spotter/pages/home/pages/HomePage.dart';
import 'package:giraffe_spotter/repositories/AuthenticationRepository.dart';
import 'package:giraffe_spotter/widgets/GradientSnackBar.dart';
import 'package:giraffe_spotter/widgets/LargeButton.dart';

class Login extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark, statusBarColor: Colors.transparent),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: Palette.primaryColor,
        extendBodyBehindAppBar: true,
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: BlocProvider(
            create: (context) => LoginCubit(AuthenticationRepository()),
            child: BlocListener<LoginCubit, LoginState>(
              listenWhen: (prev, current) => prev.status != current.status,
              listener: listenForStateChanges,
              child: Form(
                child: LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                    reverse: true,
                    scrollDirection: Axis.vertical,
                    child: IntrinsicHeight(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.46),
                              color: Palette.bannerColor,
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 32,
                                    left: 30,
                                    child: Transform.scale(
                                      scale: 1.45,
                                      child: Container(height: 350, child: Image.asset(Assets.authBanner)),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 91,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(left: 26.5),
                                          child: Text('Saving Giraffe\ntogether', style: Styles.bannerTitle.copyWith(height: 1.3)),
                                        ),
                                        SizedBox(height: 12),
                                        Container(
                                          padding: EdgeInsets.only(left: 26),
                                          child: Text('Welcome back', style: Styles.bannerSubTitle),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: Decorations.authPagesBoxDecoration,
                            child: Container(
                              decoration: Decorations.authPagesInnerBoxDecoration,
                              padding: EdgeInsets.only(right: 24, left: 26, top: 9),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  LoginInputs(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        key: Key('forgot'),
                                        onTap: () => locator!<AppRoute>().navigateTo(ForgotPassword()),
                                        child: Text("Forgot password?", style: Styles.labelTextFormField),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 32),
                                  Container(
                                    height: 52,
                                    child: BlocBuilder<LoginCubit, LoginState>(
                                      builder: (context, state) => LargeButtonReplacement(
                                        title: "Sign In",
                                        loading:
                                        (state.status.isSubmissionInProgress) ? true : false,
                                        active: (state.email.valid && state.password.valid) ? true : false,
                                        onTap: () => (state.email.valid && state.password.valid) ? context.read<LoginCubit>().signIn() : {},
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 21),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Don\'t have an account? ',
                                      style: Styles.labelTextFormField
                                          .copyWith(fontSize: 12, letterSpacing: 0, color: Palette.secondaryTextColor),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: 'Sign Up',
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () => locator!<AppRoute>().navigateAndRemoveUntil(SignUp()),
                                          style: TextStyle(color: Palette.tertiaryColor, fontFamily: 'Poppins-SemiBold'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void listenForStateChanges(BuildContext context, LoginState state) {
    if (state.status.isSubmissionFailure) {
      if (context.read<LoginCubit>().errorMessage != '') {
        GradientSnackBar.showErrorMessage(context, context.read<LoginCubit>().errorMessage);
      }
    }
    if (state.status.isSubmissionSuccess) {
      context.read<AuthenticationBloc>().add(AuthenticationUserChanged(state.user));
      locator!<AppRoute>().navigateAndRemoveUntil(HomePage());
    }
  }
}
