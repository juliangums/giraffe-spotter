import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/blocs/authentication/AuthenticationBloc.dart';
import 'package:giraffe_spotter/blocs/confirmDelete/DeleteCubit.dart';
import 'package:giraffe_spotter/blocs/edit_profile/UpdateProfileCubit.dart';
import 'package:giraffe_spotter/blocs/edit_profile/UpdateProfileState.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Constants.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/pages/authentication/Login.dart';
import 'package:giraffe_spotter/pages/authentication/SignUp.dart';
import 'package:giraffe_spotter/pages/delete_account/widgets/DeleteIcon.dart';
import 'package:giraffe_spotter/pages/delete_account/widgets/ContainModalBottom.dart';
import 'package:giraffe_spotter/repositories/UpdateProfileRepository.dart';
import 'package:giraffe_spotter/utils/SharedObjects.dart';
import 'package:giraffe_spotter/widgets/ArrowBackButton.dart';
import 'package:giraffe_spotter/widgets/CustomContainer.dart';
import 'package:giraffe_spotter/widgets/GradientSnackBar.dart';
import 'package:giraffe_spotter/widgets/LargeButton.dart';
import 'package:giraffe_spotter/widgets/PageWrapper.dart';

class DeletePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return BlocProvider(
    create: (context) => UpdateProfileCubit(new UpdateProfileRepository()),
    child: BlocProvider(
      create: (_) => DeleteCubit(initialState: false),
      child: BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
        listener:  listenUpdate,
        builder: (context, _) {
          return BlocBuilder<DeleteCubit, bool>(
                buildWhen: (previous, current) => previous != current,
                builder: (context, state) {
                  return WillPopScope(
                    onWillPop: ()=> _.status.isSubmissionInProgress?locator!<AppRoute>().navigateAndRemoveUntil(Login()):locator!<AppRoute>().back(),
                    child: PageWrapper(
                      title: '',
                      leading: _.status.isSubmissionSuccess ? ArrowBackButton(home: true) : ArrowBackButton(),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: CustomContainer(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: height/16),
                                AnimatedIconContent(deletePage: true),
                                SizedBox(height: height/12),
                                Text(
                                  "Delete Account",
                                  style: Styles.deleteAccount,
                                ),
                                SizedBox(height: 16.5),
                                ConstrainedBox(
                                  constraints: BoxConstraints.expand(height: 180, width: width),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Are you sure you want to delete your \n account?",
                                          style: Styles.deleteAccountDetails, textAlign: TextAlign.center),
                                      context.read<DeleteCubit>().initialState == false
                                          ? Text("We’re sorry to see you go!", style: Styles.deleteAccountDetails, textAlign: TextAlign.center)
                                          : RichText(
                                              textAlign: TextAlign.center,
                                              text: TextSpan(children: [
                                                TextSpan(
                                                    text: "if you want to change your email address,\n name and phone number simply do so right\n",
                                                    style: Styles.deleteAccountDetails),
                                                TextSpan(text: 'here', style: Styles.confirmDeleteHere,
                                                  recognizer: TapGestureRecognizer()..onTap = ()=> locator!<AppRoute>().navigateAndRemoveUntil(SignUp(popping: true,))
                                                )
                                              ])),
                                      DelayedDisplay(
                                        delay: Duration(milliseconds: (150)),
                                        child:
                                        RichText(
                                          textAlign: TextAlign.center,
                                          text: TextSpan(children: [
                                            TextSpan(style: Styles.deleteNote, text: 'Please note:'),
                                            TextSpan(
                                                style: Styles.deleteAccountDetails,
                                                text: ' If you delete your account you \n wont be able to reactive it later.'),
                                          ]),
                                        ),
                                        slidingBeginOffset: Offset(0.0, -0.35),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: height/10),
                                LargeButtonReplacement (
                                    title: _.status.isSubmissionSuccess ? 'Exit' :'Delete',
                                    loading: (_.status.isSubmissionInProgress) ? true: false,
                                    active: (SharedObjects.prefs!.getString(Constants.userid).toString().isNotEmpty)? true: false,
                                    wrapperMargin: EdgeInsets.symmetric(horizontal: 29),
                                    onTap: ()=> (SharedObjects.prefs!.getString(Constants.userid).toString().isNotEmpty)? _.status.isSubmissionSuccess ? locator!<AppRoute>().navigateAndRemoveUntil(Login()) :context.read<UpdateProfileCubit>().deleteProfile(context.read<AuthenticationBloc>().state.user.uuid!):{},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          },
        ),
    ),
);
  }

  //builds the Bottom dialog
  void deleteModalConfirm(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
      ),
      builder: (context) => GestureDetector(onTap:()=>Navigator.pop(context),child: ContainModalBottom(contextS: context,select: true))
    );
  }

  void listenUpdate(BuildContext context, UpdateProfileState state) {
    if(state.status == FormzStatus.submissionSuccess) {
      context.read<DeleteCubit>().updatePageState(true);
      deleteModalConfirm(context);
    }
    if(state.status == FormzStatus.submissionFailure) {
        GradientSnackBar.showErrorMessage(context, context.read<UpdateProfileCubit>().errorMessage);
    }
  }
}
