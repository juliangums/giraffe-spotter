import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/Palette.dart';

class CustomContainer extends StatelessWidget {
  final Widget child;
  const CustomContainer({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          // color gradient
          gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Palette.gradientBottom, Palette.primaryColor],
              stops: [0.1, 0.35])),
      child: child,
    );
  }
}
