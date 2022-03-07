import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/Styles.dart';

class GradientSnackBar {
  static void showPrimaryMessage(BuildContext context, String message, ) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$message',style: Styles.onBoardNext,), backgroundColor: Palette.accentColor));
  }

  //for errors
  static void showErrorMessage(BuildContext context, String error) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$error',style: Styles.onBoardNext), backgroundColor: Palette.accentColor));
  }
}


