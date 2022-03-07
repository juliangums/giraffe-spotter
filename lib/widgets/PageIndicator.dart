import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:giraffe_spotter/config/Assets.dart';

class PageIndicator extends StatelessWidget {
  final bool isActive;

  PageIndicator(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100),
      margin: EdgeInsets.symmetric(horizontal: 8),
      height: isActive ? 14 : 10,
      width: isActive ? 14 : 10,
      child: SvgPicture.asset(isActive ? Assets.active_dot : Assets.not_active_dot),
    );
  }
}
