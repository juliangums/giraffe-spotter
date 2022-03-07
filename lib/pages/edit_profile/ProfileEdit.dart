import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/blocs/edit_profile/UpdateProfileCubit.dart';
import 'package:giraffe_spotter/blocs/edit_profile/UpdateProfileState.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Constants.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/inputs/widgets/EmailInput.dart';
import 'package:giraffe_spotter/inputs/widgets/FullNameInput.dart';
import 'package:giraffe_spotter/pages/network/NoNetworkPage.dart';
import 'package:giraffe_spotter/repositories/UpdateProfileRepository.dart';
import 'package:giraffe_spotter/utils/SharedObjects.dart';
import 'package:giraffe_spotter/widgets/ArrowBackButton.dart';
import 'package:giraffe_spotter/widgets/DisplayPhoto.dart';
import 'package:giraffe_spotter/widgets/GradientSnackBar.dart';
import 'package:giraffe_spotter/widgets/LargeButton.dart';
import 'package:giraffe_spotter/widgets/PageWrapper.dart';

class ProfileEdit extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final FocusNode emailFieldFocusNode = FocusNode();
    return BlocProvider(
        create: (context) => UpdateProfileCubit(UpdateProfileRepository()),
        child: PageWrapper(
            title: 'Edit Profile',
            leading: ArrowBackButton(),
            actions: [SizedBox()],
            child: Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                           gradient: LinearGradient(
                                 begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [Palette.gradientBottom, Palette.primaryColor],
                                    stops: [0.1, 0.35]
                              )
                            ),
              child: ListView(
                children: [
                  Container(
                      child: Column(children: [
                        DisplayPhoto(drawerClose: false),
                        SizedBox(height: 10.5),
                        Container (
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(24, 21, 35, 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(height: 20),
                                Text('Full Name', style: Styles.editProfileTopics),
                                SizedBox(height: 5),
                                NameInput<UpdateProfileCubit, UpdateProfileState>(
                                    profileName: SharedObjects.prefs!.getString(Constants.name).toString().isNotEmpty
                                        ? SharedObjects.prefs!.getString(Constants.name).toString()
                                        : ''),
                                SizedBox(height: 20),
                                Text('Email', style: Styles.editProfileTopics),
                                SizedBox(height: 5),
                                EmailInput<UpdateProfileCubit, UpdateProfileState> (
                                  fieldFocusNode: emailFieldFocusNode,
                                  profileEmail: SharedObjects.prefs!.getString(Constants.userEmail).toString().isNotEmpty
                                      ? SharedObjects.prefs!.getString(Constants.userEmail).toString()
                                      : '',
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 48),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 29),
                          child: BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
                              listenWhen: (prev, current) => prev.status != current.status,
                              listener: listenForStateChanges,
                              builder: (context, state) => LargeButtonReplacement (
                                title: 'Save Profile',
                                onTap: () => (state.email.valid && state.fullName.valid && state.show == true) ? context.read<UpdateProfileCubit>().updateProfile() : {},
                                loading: (state.status.isSubmissionInProgress && (state.email.valid && state.fullName.valid) && state.show == true ) ? true : false,
                                active: (state.email.valid && state.fullName.valid && state.show == true) ? true : false,
                              )
                          ),
                        ),
                      ]
                      )
                  ),
                  SizedBox(height: 80),
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(width: double.infinity, child: SvgPicture.asset(Assets.resetPassBanner, fit: BoxFit.fill))
                  )
                ],
              ),
            )
        ),
      );
  }

  void listenForStateChanges(BuildContext context, UpdateProfileState state) {
    if (state.status.isSubmissionFailure && state.email.valid && state.fullName.valid) {
      context.read<UpdateProfileCubit>().failureReason!.maybeWhen(noInternetConnection: () {
        locator!<AppRoute>().navigateTo(NoNetworkPage());
       } , orElse: () {
        GradientSnackBar.showErrorMessage(context, context.read<UpdateProfileCubit>().errorMessage);
      });
    }

    if (state.status.isSubmissionSuccess && state.email.valid && state.fullName.valid) {
      GradientSnackBar.showSecondaryMessage(context, 'Update Successful');
    }
  }
}
