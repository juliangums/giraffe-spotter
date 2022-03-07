import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final Color? backgroundColor;
  final Color? iconColor;
  final String? icon;
  final Brightness? brightness;
  final VoidCallback? onTap;
  final List<Widget>? actions;

  AppBarWidget({this.backgroundColor, this.iconColor, this.icon, this.brightness, this.onTap, this.actions});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: AppBar().preferredSize,
      child: AppBar(
        backgroundColor: backgroundColor ?? Palette.primaryColor,
        brightness: brightness ?? Brightness.dark,
        elevation: 0.0,
        leading: InkWell(
          onTap: onTap ?? () => locator!<AppRoute>().back(),
          child: Container(
            margin: EdgeInsets.only(left: 15.0),
            child: Center(
              child: Image.asset(icon ?? Assets.arrow_back, color: iconColor ?? Palette.primaryColor, width: icon != null ? 25 : 16),
            ),
          ),
        ),
        actions: actions ?? [],
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
