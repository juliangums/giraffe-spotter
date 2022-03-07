import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/Palette.dart';

import 'Styles.dart';

class Decorations {
  static InputDecoration passwordInputDecoration(
          {String? error,
          @required VoidCallback? onTap,
          bool showPassword = false,
          double top = 0,
          double bottom = 0,
          bool dense = false}) =>
      InputDecoration(
        errorText: error,
        isDense: dense,
        contentPadding: EdgeInsets.only(top: top, bottom: bottom),
        suffixIconConstraints: BoxConstraints(maxWidth: 50),
        suffixIcon: Transform.translate(
          offset: Offset(-7, -3),
          child: GestureDetector(
            key:Key('show'),
            onTap: onTap,
            child: Icon(showPassword ? Icons.visibility_off : Icons.visibility, color: Palette.secondaryTextColor, size: 20),
          ),
        ),
      );

  static BoxDecoration donateButtonDecoration() => BoxDecoration(
      color: Palette.accentColor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [BoxShadow(color: Palette.boxShadowColor, spreadRadius: 0, blurRadius: 10, offset: Offset(0, 6))]);

  static BoxDecoration

  cardSliderDecoration() => BoxDecoration(
      color: Palette.containerColor,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [BoxShadow(color: Palette.boxShadowColor, spreadRadius: 1, blurRadius: 4, offset: Offset(1, 2))]);

  static InputDecoration searchFieldDecoration(String hintword) => InputDecoration(
        contentPadding: EdgeInsets.only(top: 16),
        focusColor: Palette.secondaryTextColor,
        filled: true,
        fillColor: Palette.searchBarColor,
        prefixIcon: Icon(Icons.search, color: Palette.primaryTextColor.withOpacity(0.5)),
        hintText: "Search $hintword by name",
        hintStyle: Styles.hintText,
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(width: 0, color: Palette.bannerColor), borderRadius: BorderRadius.circular(10)),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(width: 0, color: Palette.bannerColor), borderRadius: BorderRadius.circular(10)),
        border: OutlineInputBorder(borderSide: BorderSide(width: 0, color: Palette.bannerColor), borderRadius: BorderRadius.circular(10)),
      );

  static InputDecoration setUnderlineInputBorder() => InputDecoration(
        isDense: true,
        suffixIconConstraints: BoxConstraints(maxWidth: 50),
      );

  static InputDecoration passwordInputDecoration2({required VoidCallback onTap, required bool showPassword}) => InputDecoration(
        isDense: true,
        suffixIconConstraints: BoxConstraints(maxWidth: 50),
        suffixIcon: Transform.translate(
          offset: Offset(0, -2),
          child: GestureDetector(
            key:Key('show'),
            onTap: onTap,
            child: Icon(showPassword ? Icons.visibility_off : Icons.visibility, color: Palette.secondaryTextColor, size: 20),
          ),
        ),
      );

  static BoxDecoration get onBoardingContainersDecoration => BoxDecoration(
      color: Colors.white, borderRadius: BorderRadius.only(topRight: const Radius.circular(10.0), topLeft: const Radius.circular(10.0)));

  static BoxDecoration get authPagesBoxDecoration => BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Palette.bannerColor, Palette.primaryColor],
          stops: [0.1, 0.35]));

  static BoxDecoration get authPagesInnerBoxDecoration => BoxDecoration(
      color: Palette.containerColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16)));
}
