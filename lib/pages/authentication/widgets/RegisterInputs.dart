import 'package:flutter/material.dart';
import 'package:giraffe_spotter/blocs/authentication/sign_up/Bloc.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/inputs/widgets/EmailInput.dart';
import 'package:giraffe_spotter/inputs/widgets/FullNameInput.dart';
import 'package:giraffe_spotter/inputs/widgets/PasswordInput.dart';

class RegisterInputs extends StatelessWidget {
  final FocusNode passwordFieldFocusNode = FocusNode();
  final FocusNode emailFieldFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24, left: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            'Full Name',
            style: Styles.bannerSubTitle.copyWith(fontSize: 12, color: Palette.secondaryTextColor),
          ),
          NameInput<SignUpCubit, SignUpState>(profileName: ''),
          SizedBox(height: 20),
          Text(
            'Email',
            style: Styles.bannerSubTitle.copyWith(fontSize: 12, color: Palette.secondaryTextColor),
          ),
          EmailInput<SignUpCubit, SignUpState>(fieldFocusNode: emailFieldFocusNode, nextFieldFocusNode: passwordFieldFocusNode,profileEmail: ''),
          SizedBox(height: 20),
          Text('Password', style: Styles.bannerSubTitle.copyWith(fontSize: 12, color: Palette.secondaryTextColor)),
          PasswordInput<SignUpCubit, SignUpState>(fieldFocusNode: passwordFieldFocusNode),
        ],
      ),
    );
  }
}
