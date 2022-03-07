import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/config/Styles.dart';

class TopBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String topic;
  final bool leading;
  final String icon;

  TopBarWidget({required this.topic, required this.leading, required this.icon});

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: AppBar().preferredSize,
      child: AppBar(
        backgroundColor: Colors.transparent,
        brightness: Brightness.light,
        primary: false,
        centerTitle: true,
        automaticallyImplyLeading: true,
        elevation: 0.0,
        title: Text(topic, style: Styles.pageTopic),
        leading: leading
            ? InkWell(
                onTap: () => locator!<AppRoute>().back(),
                child: Container(
                  margin: EdgeInsets.only(left: 19.7),
                  child: Center(
                    child: Image.asset(icon, width: 25, color: Palette.passwordToggleColor),
                  ),
                ),
              )
            : InkWell(),
      ),
    );
  }

  @override
  Size get preferredSize => AppBar().preferredSize;
}
