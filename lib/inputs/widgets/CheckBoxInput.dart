import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/blocs/authentication/sign_up/SignUpCubit.dart';
import 'package:giraffe_spotter/blocs/authentication/sign_up/SignUpState.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterChecker<C extends Cubit<S>, S> extends StatelessWidget {

  _launchURL(String _url) async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C,S>(
      buildWhen: buildWhen,
      builder: (context, state) {
       return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Transform.translate(
                offset: Offset(11, -1),
                child: Transform.scale(
                  scale: 0.85,
                  child: Checkbox(
                    checkColor: Palette.primaryColor,
                    activeColor: Palette.tertiaryColor,
                    value: initialValue(state),
                    onChanged: (bool? value) => onChange(context, state, value!),
                  ),
                ),
              ),
              SizedBox(width: 5),
              Padding(
                padding: const EdgeInsets.only(top: 12.6),
                child:
                RichText(
                  text: TextSpan(
                    text: "By creating an account you agree with our ",
                    style: Styles.labelTextFormField.copyWith(height: 1.21),
                    children: [
                      TextSpan(
                          text: "terms\nand conditions",
                          recognizer: TapGestureRecognizer()..onTap = () => _launchURL('https://giraffe-spotter.synt.ax/userAgreement.jsp'),
                          style: Styles.labelTextFormFieldTap.copyWith(height: 1.21),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          if(errorMessage(state)!= null) Text(errorMessage(state)!,style: TextStyle(color: Palette.redColor,fontSize: 11.5),)
      ],
    );
  },
);
  }

  bool buildWhen(S previous, S current) {
    if (previous is SignUpState && current is SignUpState) return previous.acceptTerms != current.acceptTerms;

    return false;
  }

  bool? initialValue(S state) {
    if (state is SignUpState) return state.acceptTerms.value;

    return null;
  }

  String? errorMessage(S state) {
    if (state is SignUpState)
      return state.acceptTerms.invalid
          ? 'The Terms and Condition is required.'
          : state.errors != null && state.errors!.containsKey('termsOfAgreement')
              ? state.errors!['termsOfAgreement']!.first
              : null;

    return null;
  }

  void onChange(BuildContext context, S state, bool value) {
    if (state is SignUpState) context.read<SignUpCubit>().acceptTermsChanged(value);
  }
}
