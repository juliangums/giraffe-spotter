import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/pages/authentication/Login.dart';

class ArrowBackButton extends StatelessWidget {

  final Color colors;
  final bool login;
  final bool home;

  ArrowBackButton({this.colors = Palette.dividerColor,this.home = false, this.login = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => home == true ?
      locator!<AppRoute>().navigateAndRemoveUntil(Login()) : login == true ?
      Platform.isAndroid ? SystemNavigator.pop():exit(0) :
      locator!<AppRoute>().back(),
      key: Key('backButton'),
      child: Padding(
        padding: EdgeInsets.only(left: 24, right: 10),
        child: Icon(Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios, color: colors),
      ),
    );
  }
}
