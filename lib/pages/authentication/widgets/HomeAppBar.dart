import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giraffe_spotter/config/Assets.dart';

class HomeAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(Assets.menuIcon),
          // SvgPicture.asset(Assets.LogoIcon),
          SvgPicture.asset(Assets.notifications),
        ],
      ),
    );
  }
}
