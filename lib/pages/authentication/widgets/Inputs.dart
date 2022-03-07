import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/blocs/authentication/PasswordCubit.dart';
import 'package:giraffe_spotter/blocs/authentication/forgot_password/ForgotCubit.dart';
import 'package:giraffe_spotter/blocs/authentication/login/LoginCubit.dart';
import 'package:giraffe_spotter/blocs/authentication/login/LoginState.dart';
import 'package:giraffe_spotter/blocs/authentication/resetPassword/ResetCubit.dart';
import 'package:giraffe_spotter/config/Decorations.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/Styles.dart';

class NameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
        key: Key('fullName'),
        enableSuggestions: true,
        maxLines: 1,
        cursorWidth: 1.0,
        textInputAction: TextInputAction.next,
        keyboardType: TextInputType.text,
        textDirection: TextDirection.ltr,
        cursorColor: Palette.secondaryTextColor,
        decoration: InputDecoration(isDense: true, contentPadding: EdgeInsets.only(bottom: 4, top: 5)));
  }
}

class EmailInput extends StatelessWidget {
  final FocusNode? fieldFocusNode;
  final FocusNode? nextFieldFocusNode;

  const EmailInput({Key? key, this.fieldFocusNode, this.nextFieldFocusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return TextFormField(
          enableSuggestions: true,
          key: Key('email'),
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
          maxLines: 1,
          cursorWidth: 1.0,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          textDirection: TextDirection.ltr,
          style: Styles.bannerSubTitle.copyWith(color: Palette.primaryTextColor, fontSize: 16),
          cursorColor: Palette.secondaryTextColor,
          decoration: InputDecoration(
            errorText: state.email.invalid
                ? 'Please enter email.'
                : state.formErrors != null && state.formErrors!.containsKey('email')
                    ? (state.formErrors!['email'] as List).first
                    : null,
            isDense: true,
            contentPadding: EdgeInsets.only(
              bottom: 4,
              top: 5,
            ),
          ),
          autofillHints: [AutofillHints.email],
        );
      },
    );
  }
}

class ForgotEmailInput extends StatelessWidget {
  final FocusNode? fieldFocusNode;
  final FocusNode? nextFieldFocusNode;
  ForgotEmailInput({Key? key, this.fieldFocusNode, this.nextFieldFocusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotCubit, ForgotState>(
      builder: (context, state) {
        return TextFormField(
          enableSuggestions: true,
          key: Key('email'),
          onChanged: (email) => context.read<ForgotCubit>().emailChange(email),
          maxLines: 1,
          cursorWidth: 1.0,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          textDirection: TextDirection.ltr,
          style: Styles.bannerSubTitle.copyWith(color: Palette.primaryTextColor, fontSize: 16),
          cursorColor: Palette.secondaryTextColor,
          focusNode: fieldFocusNode,
          decoration: InputDecoration(
            errorText: state.email.invalid
                ? 'Please enter email.'
                : state.formErrors != null && state.formErrors!.containsKey('email')
                    ? (state.formErrors!['email'] as List).first
                    : null,
            isDense: true,
            contentPadding: EdgeInsets.only(
              bottom: 4,
              top: 5,
            ),
          ),
          autofillHints: [AutofillHints.email],
        );
      },
    );
  }
}

class PasswordInput extends StatelessWidget {
  final FocusNode fieldFocusNode;

  PasswordInput({Key? key, required this.fieldFocusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PasswordCubit(),
      child: BlocBuilder<LoginCubit, LoginState>(
        builder: (context, state) {
          return BlocBuilder<PasswordCubit, bool>(
            builder: (context, show) {
              return TextFormField(
                key: Key('password'),
                onChanged: (password) => context.read<LoginCubit>().passwordChanged(password),
                onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
                cursorWidth: 1.0,
                maxLines: 1,
                obscureText: show,
                cursorColor: Palette.secondaryTextColor,
                decoration: Decorations.passwordInputDecoration(
                    error: state.password.invalid
                        ? 'Please enter password.'
                        : state.formErrors != null && state.formErrors!.containsKey('password')
                            ? (state.formErrors!['password'] as List).first
                            : null,
                    onTap: () => context.read<PasswordCubit>().toggleVisibility(),
                    showPassword: show,
                    top: 4,
                    bottom: 4,
                    dense: true),
                autofillHints: [AutofillHints.password],
              );
            },
          );
        },
      ),
    );
  }
}

class AcceptTermsInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile();
  }
}

class ResetPasswordInput extends StatelessWidget {
  final FocusNode fieldFocusNode;

  ResetPasswordInput({Key? key, required this.fieldFocusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PasswordCubit(),
      child: BlocBuilder<ResetCubit, ResetState>(
        builder: (context, state) {
          return BlocBuilder<PasswordCubit, bool>(
            builder: (context, show) {
              return TextFormField(
                key: Key('password'),
                onChanged: (password) => context.read<ResetCubit>().passwordChanged(password),
                onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
                cursorWidth: 1.0,
                maxLines: 1,
                obscureText: show,
                cursorColor: Palette.secondaryTextColor,
                decoration: Decorations.passwordInputDecoration(
                    error: state.password.invalid
                        ? 'Please enter password.'
                        : state.formErrors != null && state.formErrors!.containsKey('password')
                        ? (state.formErrors!['password'] as List).first
                        : null,
                    onTap: () => context.read<PasswordCubit>().toggleVisibility(),
                    showPassword: show,
                    top: 4,
                    bottom: 4,
                    dense: true),
                autofillHints: [AutofillHints.password],
              );
            },
          );
        },
      ),
    );
  }
}

class ConfirmPasswordInput extends StatelessWidget {
  final FocusNode fieldFocusNode;

  ConfirmPasswordInput({Key? key, required this.fieldFocusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PasswordCubit(),
      child: BlocBuilder<ResetCubit, ResetState>(
        builder: (context, state) {
          return BlocBuilder<PasswordCubit, bool>(
            builder: (context, show) {
              return TextFormField (
                key: Key('password'),
                onChanged: (password) => context.read<ResetCubit>().confirmPasswordChanged(password),
                onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
                cursorWidth: 1.0,
                maxLines: 1,
                obscureText: show,
                cursorColor: Palette.secondaryTextColor,
                decoration: Decorations.passwordInputDecoration(
                    error: state.password.invalid
                        ? 'Please enter password.': null,
                    onTap: () => context.read<PasswordCubit>().toggleVisibility(),
                    showPassword: show,
                    top: 4,
                    bottom: 4,
                    dense: true),
                autofillHints: [AutofillHints.password],
              );
            },
          );
        },
      ),
    );
  }
}