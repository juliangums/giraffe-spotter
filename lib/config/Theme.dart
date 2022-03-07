import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/Styles.dart';

class Themes {
  static ThemeData primaryTheme = ThemeData(
    primaryColor: Palette.primaryColor,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    fontFamily: 'Poppins-Regular',
    inputDecorationTheme: InputDecorationTheme(
      border: UnderlineInputBorder(borderSide: BorderSide(color: Palette.textFieldUnderlineColor, width: 1)),
      labelStyle: Styles.labelTextFormField,
      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.textFieldUnderlineColor, width: 1)),
      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Palette.textFieldUnderlineColor, width: 1)),
    ),
  );
}
