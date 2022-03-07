import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/Palette.dart';

class GradientSnackBar {
  static void showPrimaryMessage(BuildContext context, String message, {VoidCallback? onClose}) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(
              content: Text(
                '$message',
                style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
              backgroundColor: Palette.bodyBackgroundColor))
          .closed
          .then((value) => null != onClose ? onClose() : null);
  }

  static void showSecondaryMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$message'), backgroundColor: Palette.greenColor));
  }

  static void showErrorMessage(BuildContext context, String? error) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text('$error'), backgroundColor: Palette.redColor));
  }
}
