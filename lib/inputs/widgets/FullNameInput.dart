import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/blocs/authentication/sign_up/Bloc.dart';
import 'package:giraffe_spotter/blocs/edit_profile/UpdateProfileCubit.dart';
import 'package:giraffe_spotter/blocs/edit_profile/UpdateProfileState.dart';
import 'package:giraffe_spotter/config/Palette.dart';

class NameInput<C extends Cubit<S>, S> extends StatelessWidget {
  NameInput({this.profileName});
  final String? profileName;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, S>(
      buildWhen: buildWhen,
      builder: (context, state) {
        return TextFormField(
          key: Key('fullName'),
          enableSuggestions: true,
          textCapitalization: TextCapitalization.sentences,
          maxLines: 1,
          cursorWidth: 1.0,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.text,
          textDirection: TextDirection.ltr,
          cursorColor: Palette.secondaryTextColor,
          onChanged: (String value) => onChange(context, state, value),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.only(bottom: 4, top: 4),
            errorText: errorMessage(state),
          ),
          initialValue: initialValue(context, state) != null ? profileName! : initialValue(context, state),
        );
      },
    );
  }

  bool buildWhen(S previous, S current) {
    if (previous is SignUpState && current is SignUpState) return previous.fullName != current.fullName;
    if (previous is UpdateProfileState && current is UpdateProfileState) return previous.fullName != current.fullName;
    return false;
  }

  String? initialValue(BuildContext context, S state) {
    if (state is SignUpState) return state.fullName.value;
    if (state is UpdateProfileState) {
      if(state.fullName.value.isEmpty){context.read<UpdateProfileCubit>().nameChanged(profileName!, false);}
      return state.fullName.value;
    }
    return null;
  }

  String? errorMessage(S state) {
    if (state is SignUpState)
      return state.fullName.invalid
          ? 'The full name field is required.'
          : state.errors != null && state.errors!.containsKey('fullName')
              ? state.errors!['fullName']!.first
              : null;
    if (state is UpdateProfileState)
      return state.fullName.invalid
          ? 'Please enter a valid name.'
          : state.errors != null && state.errors!.containsKey('email')
              ? state.errors!['name']!.first
              : null;

    return null;
  }

  void onChange(BuildContext context, S state, String value) {
    if (state is SignUpState) context.read<SignUpCubit>().nameChanged(value);
    if (state is UpdateProfileState) context.read<UpdateProfileCubit>().nameChanged(value, true);
  }
}
