import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/blocs/authentication/PasswordCubit.dart';
import 'package:giraffe_spotter/blocs/authentication/sign_up/Bloc.dart';
import 'package:giraffe_spotter/config/Decorations.dart';
import 'package:giraffe_spotter/config/Palette.dart';

class PasswordInput<C extends Cubit<S>, S> extends StatelessWidget {
  PasswordInput({this.fieldFocusNode});
  final fieldFocusNode;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<C, S>(
      // buildWhen: buildWhen,
      builder: (context, state) => BlocProvider(
        create: (_) => PasswordCubit(),
        child: BlocBuilder<PasswordCubit, bool>(
          builder: (context, show) {
            return TextFormField(
              key: Key('password'),
              obscureText: show,
              cursorColor: Palette.secondaryTextColor,
              onChanged: (String value) => onChange(context, state, value),
              decoration: Decorations.passwordInputDecoration(
                onTap: () => context.read<PasswordCubit>().toggleVisibility(),
                showPassword: show,
                top: 2,
                bottom: 2,
                dense: true,
                error: errorMessage(state),
              ),
            );
          },
        ),
      ),
    );
  }

  bool buildWhen(S previous, S current) {
    if (previous is SignUpState && current is SignUpState) return previous.password != current.password;

    return false;
  }

  String? initialValue(S state) {
    if (state is SignUpState) return state.password.value;

    return null;
  }

  String? errorMessage(S state) {
    if (state is SignUpState)
      return state.password.invalid
          ? 'The password field is required.'
          : state.errors != null && state.errors!.containsKey('password')
              ? state.errors!['password']!.first
              : null;

    return null;
  }

  void onChange(BuildContext context, S state, String value) {
    if (state is SignUpState) context.read<SignUpCubit>().passwordChanged(value);
  }
}
