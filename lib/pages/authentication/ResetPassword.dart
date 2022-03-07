import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/blocs/authentication/resetPassword/ResetCubit.dart';
import 'package:giraffe_spotter/blocs/dynamic_links/DynamicCubit.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Constants.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/pages/authentication/Login.dart';
import 'package:giraffe_spotter/pages/authentication/widgets/Inputs.dart';
import 'package:giraffe_spotter/repositories/AuthenticationRepository.dart';
import 'package:giraffe_spotter/utils/SharedObjects.dart';
import 'package:giraffe_spotter/widgets/GradientSnackBar.dart';
import 'package:giraffe_spotter/widgets/LargeButton.dart';
import 'package:giraffe_spotter/widgets/PageWrapper.dart';

class ResetPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return PageWrapper(
      title: "Reset Password",
      leading: GestureDetector(
        onTap: () => locator!<AppRoute>().navigateAndRemoveUntil(Login()),
        key: Key('backButton'),
        child: Padding(
          padding: EdgeInsets.only(left: 24, right: 10),
          child: Icon(Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios, color: Palette.dividerColor),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: IntrinsicHeight(
            child: Container(
              height: height / 1.19,
              child: Stack(
                children: [
                  Positioned(
                    bottom: 0,
                    left: 30,
                    child: Transform.scale(
                      scale: 1.2,
                      child: Container(
                        child: SvgPicture.asset(Assets.resetPassBanner),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Column(
                      children: [
                        Container(
                            padding: EdgeInsets.only(left: 24, right: 24),
                            child: Text (
                              "Your new password must be different from previous used passwords",
                              style: Styles.bodyText,
                            )
                        ),
                        SizedBox(height: 50),
                        Container(width: width, padding: EdgeInsets.only(right: 24, left: 24), child: Form()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class Form extends StatelessWidget {
  final FocusNode passwordFieldFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => ResetCubit(AuthenticationRepository()),
        child: BlocConsumer<ResetCubit, ResetState>(
          listener: listening,
        builder: (context, state) {
          return Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'New Password',
                        style: Styles.bannerSubTitle.copyWith(fontSize: 12, color: Palette.secondaryTextColor),
                      ),
                      ResetPasswordInput(fieldFocusNode: passwordFieldFocusNode),
                      SizedBox(height: 18.5),
                      Text(
                        'Confirm Password',
                        style: Styles.bannerSubTitle.copyWith(fontSize: 12, color: Palette.secondaryTextColor),
                      ),
                      ConfirmPasswordInput(fieldFocusNode: passwordFieldFocusNode),
                      SizedBox(height: 46),
                      BlocBuilder<DynamicCubit, DynamicState>(
                        builder: (context, _) {
                          return Container(
                            child: LargeButtonReplacement(
                              title: "Reset Password",
                              onTap: () async {
                                if(_.data != null) {
                                  context.read<ResetCubit>().emailChanged(_.data);
                                } else{
                                  context.read<ResetCubit>().emailChanged(SharedObjects.prefs!.getString(Constants.userEmail));
                                }
                                if(state.password.valid && state.confirmPassword.valid)context.read<ResetCubit>().reset();
                              },
                              active: (state.password.valid && state.confirmPassword.valid)? true : false,
                              loading: (state.status.isSubmissionInProgress)? true: false,
                          ),
                        );
                      },
                    ),
                   ],
                  ),
                );
        },
      ),
    );
  }

  Future<void> listening(BuildContext context, ResetState state) async {
    if(state.status.isSubmissionSuccess){
      GradientSnackBar.showSecondaryMessage(context, 'Reset successful');
      locator!<AppRoute>().navigateTo(Login());
    }
    if(state.status.isSubmissionFailure){
      if(state.formErrors != null && ((state.formErrors!.containsKey('link') || (state.formErrors!.containsKey('token'))))) {
        await SharedObjects.prefs!.setString(Constants.reset, '');
        GradientSnackBar.showErrorMessage(context, 'Process failed. Enter your email address and try again..');
      }
    }
  }
}
