import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/Decorations.dart';
import 'package:giraffe_spotter/config/Styles.dart';

class DonateButton extends StatelessWidget {
  final String label;
  final action;
  DonateButton({required this.label, required this.action});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: action,
      child: Container(
        height: 54,
        width: 120,
        decoration: Decorations.donateButtonDecoration(),
        child: Center(
          child: Text(label, textAlign: TextAlign.center, style: Styles.buttonText),
        ),
      ),
    );
  }
}
