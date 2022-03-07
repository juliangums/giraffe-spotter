import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/Styles.dart';

// ignore: must_be_immutable
class MapSearchBar extends StatelessWidget {
  String? hintText;
  MapSearchBar({this.hintText});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Palette.primaryColor,
        borderRadius: new BorderRadius.only(
          topRight: const Radius.circular(10.0),
          topLeft: const Radius.circular(10.0),
          bottomLeft: const Radius.circular(10.0),
          bottomRight: const Radius.circular(10.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2.0,
            offset: Offset(1.0, 1.0), // shadow direction: bottom right
          )
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          border: InputBorder.none,
          hintStyle: Styles.mapSearchText,
          prefixIcon: Transform.translate(
              offset: Offset(6.5, 0),
              child: Image.asset(
                Assets.search,
                color: Palette.secondaryTextColor,
              )),
        ),
      ),
    );
  }
}
