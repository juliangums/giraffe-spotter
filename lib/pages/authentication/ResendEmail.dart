import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/blocs/authentication/forgot_password/ForgotCubit.dart';
import 'package:giraffe_spotter/blocs/dynamic_links/DynamicCubit.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/widgets/ArrowBackButton.dart';
import 'package:giraffe_spotter/widgets/GradientSnackBar.dart';
import 'package:giraffe_spotter/widgets/LargeButton.dart';
import 'package:giraffe_spotter/widgets/PageWrapper.dart';
import 'package:open_mail_app/open_mail_app.dart';

class ResendEmail extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return BlocConsumer<ForgotCubit,ForgotState>(
        listener: listenerMail,
        builder: (context, state) {
          return PageWrapper(
              title: "Resend Email",
              leading: ArrowBackButton(),
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: IntrinsicHeight(
                    child: Container(
                      height: height / 1.17,
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
                                Flexible(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 24, right: 24, bottom: 33.16),
                                    child: Text(
                                      "Please check your email, we’ve sent instructions to reset your password.",
                                      style: Styles.bodyText,
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    margin: EdgeInsets.only(left: 89, right: 89),
                                    decoration: BoxDecoration(
                                      image: DecorationImage(image: AssetImage(Assets.resendIcon), fit: BoxFit.contain),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    padding: EdgeInsets.only(left: 40, right: 41, top: 41),
                                    child: RichText(
                                      textAlign: TextAlign.center,
                                      text: TextSpan(
                                        text: 'Didn’t receive an email? Check your spam folder or ',
                                        style: Styles.labelTextFormField,
                                        children: <TextSpan>[
                                          TextSpan(
                                              text: 'resend the email',
                                              style: Styles.spanText,
                                              recognizer: TapGestureRecognizer()..onTap = () => context.read<ForgotCubit>().sendMail(context.read<DynamicCubit>().state.shorturl,context.read<ForgotCubit>().state.email, false),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 50),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 24),
                                  child: LargeButtonReplacement(
                                    title: "Open Email",
                                    loading:(state.status.isSubmissionInProgress)? true: false,
                                    onTap: () async{
                                      var result = await OpenMailApp.openMailApp();
                                      if (!result.didOpen && !result.canOpen) {
                                        GradientSnackBar.showErrorMessage(context, 'No Mail app installed !');
                                      } else if (!result.didOpen && result.canOpen) {
                                        showDialog(
                                          context: context,
                                          builder: (_) {
                                            return MailAppPickerDialog(
                                              mailApps: result.options,
                                              );
                                            },
                                          );
                                        }
                                      },
                                  ),
                                ),
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
        },
      );
   }

  void listenerMail(BuildContext context, ForgotState state) {

    if(state.status == FormzStatus.submissionSuccess){
      GradientSnackBar.showSecondaryMessage(context, 'Email sent successfully');
    }
    if(state.status == FormzStatus.submissionFailure){
      GradientSnackBar.showErrorMessage(context, 'Process Failed.');
    }
  }
}
