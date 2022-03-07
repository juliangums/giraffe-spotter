import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/Styles.dart';

import 'Inputs.dart';

class LoginInputs extends StatelessWidget {
  final FocusNode passwordFieldFocusNode = FocusNode();
  final FocusNode emailFieldFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 24),
        Text(
          'Email',
          style: Styles.bannerSubTitle.copyWith(fontSize: 12, color: Palette.secondaryTextColor),
        ),
        EmailInput(fieldFocusNode: emailFieldFocusNode, nextFieldFocusNode: passwordFieldFocusNode),
        SizedBox(height: 24),
        Text('Password', style: Styles.bannerSubTitle.copyWith(fontSize: 12, color: Palette.secondaryTextColor)),
        PasswordInput(fieldFocusNode: passwordFieldFocusNode),
        SizedBox(height: 7.8),
      ],
    );
  }
}
