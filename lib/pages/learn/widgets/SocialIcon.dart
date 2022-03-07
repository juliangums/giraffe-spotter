import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// ignore: must_be_immutable
class SocialIcon extends StatelessWidget {
  String icon;
  SocialIcon({required this.icon});
  @override
  Widget build(BuildContext context) {
    return Container(child: SvgPicture.asset(icon));
  }
}
