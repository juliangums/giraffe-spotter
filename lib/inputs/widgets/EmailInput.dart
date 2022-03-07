import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/blocs/authentication/sign_up/Bloc.dart';
import 'package:giraffe_spotter/blocs/edit_profile/UpdateProfileCubit.dart';
import 'package:giraffe_spotter/blocs/edit_profile/UpdateProfileState.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/Styles.dart';

class EmailInput<C extends Cubit<S>, S> extends StatelessWidget {
  EmailInput({this.fieldFocusNode, this.nextFieldFocusNode, this.profileEmail});
  final fieldFocusNode, nextFieldFocusNode;
  final String? profileEmail;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, S>(
      // buildWhen: buildWhen,
      builder: (context, state) => TextFormField(
        key: Key('email'),
        enableSuggestions: true,
        maxLines: 1,
        cursorWidth: 1.0,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.emailAddress,
        textDirection: TextDirection.ltr,
        style: Styles.bannerSubTitle.copyWith(color: Palette.primaryTextColor, fontSize: 16),
        cursorColor: Palette.secondaryTextColor,
        onChanged: (String value) => onChange(context, state, value),
        decoration: InputDecoration(
          isDense: true,
          contentPadding: EdgeInsets.only(bottom: 4, top: 4),
          errorText: errorMessage(state),
        ),
        initialValue: initialValue(context, state) != null ? profileEmail : initialValue(context, state),
      ),
    );
  }

  bool buildWhen(S previous, S current) {
    if (previous is SignUpState && current is SignUpState) return previous.email != current.email;
    if (previous is UpdateProfileState && current is UpdateProfileState) return previous.email != current.email;
    return false;
  }

  String? initialValue(BuildContext context, S state) {
    if (state is SignUpState) return state.email.value;
    if (state is UpdateProfileState) {
      if (state.email.value.isEmpty) {
        context.read<UpdateProfileCubit>().emailChanged(profileEmail!, false);
      }
      return state.email.value;
    }
    return null;
  }

  String? errorMessage(S state) {
    if (state is SignUpState)
      return state.email.invalid
          ? 'Please enter a valid email.'
          : state.errors != null && state.errors!.containsKey('email')
              ? state.errors!['email']!.first
              : null;
    if (state is UpdateProfileState)
      return state.email.invalid
          ? 'Please enter a valid email.'
          : state.errors != null && state.errors!.containsKey('email')
              ? state.errors!['email']!.first
              : null;
    return null;
  }

  void onChange(BuildContext context, S state, String value) {
    if (state is SignUpState) context.read<SignUpCubit>().emailChanged(value);
    if (state is UpdateProfileState) context.read<UpdateProfileCubit>().emailChanged(value, true);
  }
}
