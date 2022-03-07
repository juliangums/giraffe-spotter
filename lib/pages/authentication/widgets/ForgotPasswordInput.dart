import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/Styles.dart';

import 'Inputs.dart';

class ForgotPasswordInput extends StatelessWidget {
  final FocusNode passwordFieldFocusNode = FocusNode();
  final FocusNode emailFieldFocusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email',
            style: Styles.bannerSubTitle.copyWith(fontSize: 12, color: Palette.secondaryTextColor),
          ),
          ForgotEmailInput(fieldFocusNode: emailFieldFocusNode),
        ],
      ),
    );
  }
}
