import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/blocs/authentication/forgot_password/ForgotCubit.dart';
import 'package:giraffe_spotter/blocs/dynamic_links/DynamicCubit.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/pages/authentication/ResendEmail.dart';
import 'package:giraffe_spotter/pages/authentication/widgets/ForgotPasswordInput.dart';
import 'package:giraffe_spotter/pages/authentication/widgets/Inputs.dart';
import 'package:giraffe_spotter/widgets/ArrowBackButton.dart';
import 'package:giraffe_spotter/widgets/GradientSnackBar.dart';
import 'package:giraffe_spotter/widgets/LargeButton.dart';
import 'package:giraffe_spotter/widgets/PageWrapper.dart';

class ForgotPassword extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocConsumer<ForgotCubit, ForgotState>(
    listener: listenerForgot,
    listenWhen: (prev,current)=> prev.status != current.status,
    builder: (context, state) {
    return PageWrapper(
      title: 'Forgot Password',
      leading: Padding(padding: EdgeInsets.only(top: 15, left: 2), child: ArrowBackButton()),
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: IntrinsicHeight(
            child: GestureDetector(
              onTap:(){
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
              },
              child: Container(
                  height: height / 1.14,
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 0,
                        left: 30,
                        child: Transform.scale(
                          scale: 1.2,
                          child: Container(
                            child: SvgPicture.asset(Assets.forgiveAssets),
                          ),
                        ),
                      ),
                      Positioned.fill(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 5.8),
                            Container(
                                padding: EdgeInsets.only(right: 25.5, left: 24),
                                child: Text(
                                  "Enter your email address here to reset your password.\nIf the email address exists, we’ll send you instructions\nto reset your password.",
                                  style: Styles.bodyText.copyWith(height: 2.042),
                                  textAlign: TextAlign.start,
                                )),
                            SizedBox(height: 48.1),
                            ForgotPasswordInput(),
                            SizedBox(height: 50.5),
                            BlocConsumer<DynamicCubit, DynamicState>(
                              listener: listenDynamic,
                              builder: (context, _) {
                                return Container(
                                  padding:EdgeInsets.symmetric(horizontal: 25),
                                  child: LargeButtonReplacement(
                                    title: "Send Instructions",
                                    active: (state.email.valid)? true : false,
                                    loading: (state.status.isSubmissionInProgress)?true:false,
                                    onTap: (){if(state.email.valid) {
                                        context.read<ForgotCubit>().changePage(true);
                                        context.read<DynamicCubit>().createDynamicLink(state.email.value, true);
                                        }
                                      }
                                    )
                                  );
                              },
                            ),
                            SizedBox(height: 106.8),
                          ],
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ),
      ));
  },
);
  }

  void listenerForgot(BuildContext context, ForgotState state) {
    if(state.status == FormzStatus.submissionFailure){
      // GradientSnackBar.showErrorMessage(context, context.read<ForgotCubit>().errorMessage);
    }
    if(state.status == FormzStatus.submissionSuccess && state.page == true){
      locator!<AppRoute>().navigateTo(ResendEmail());
      context.read<ForgotCubit>().changePage(false);
    }
  }

  void listenDynamic(BuildContext context, DynamicState state) {
    if(state.status.isSubmissionSuccess && state.home == true){
      context.read<ForgotCubit>().sendMail(state.shorturl,context.read<ForgotCubit>().state.email,true);
    }
  }
}

class FormInput extends StatelessWidget {
  final FocusNode emailFieldFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          EmailInput(fieldFocusNode: emailFieldFocusNode),
          SizedBox(height: 50),
          Container(
            child: LargeButton(
              onTap: () => locator!<AppRoute>().navigateTo(ResendEmail()),
              title: "Send Instructions",
              widthSize: 5,
              heightSize: 52,
            ),
          ),
        ],
      ),
    );
  }
}
