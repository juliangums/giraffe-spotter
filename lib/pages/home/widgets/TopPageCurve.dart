import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/Assets.dart';

class TopPageCurve extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 10,
        child: Container(
          child: Image.asset(Assets.topPageCurve),
        ));
  }
}
