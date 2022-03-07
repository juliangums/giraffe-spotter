import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_smartlook/flutter_smartlook.dart';

class AppRoute {
  GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateTo(Widget page, {RouteSettings? settings}) {
    Smartlook.trackNavigationEvent(page.toString(), SmartlookNavigationEventType.enter);
    return navigatorKey.currentState!.push(_pageRoute(page, settings: settings));
  }

  Future<dynamic> navigateAndReplace(Widget page, {RouteSettings? settings}) {
    Smartlook.trackNavigationEvent(page.toString(), SmartlookNavigationEventType.enter);
    return navigatorKey.currentState!.pushReplacement(_pageRoute(page, settings: settings));
  }

  Future<dynamic> navigateAndRemoveUntil(Widget page, {RouteSettings? settings}) {
    Smartlook.trackNavigationEvent(page.toString(), SmartlookNavigationEventType.enter);
    return navigatorKey.currentState!.pushAndRemoveUntil(_pageRoute(page, settings: settings), (Route<dynamic> route) => false);
  }

  dynamic back({dynamic params}) {
    return navigatorKey.currentState!.pop(params);
  }

  PageRoute _pageRoute(Widget page, {RouteSettings? settings}) {
    return Platform.isIOS
        ? MaterialPageRoute(builder: (context) => page, settings: settings)
        : PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => page, settings: settings, transitionsBuilder: _createTransition);
  }

  Widget _createTransition(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    var begin = Platform.isIOS ? Offset(1.0, .0) : Offset(0.0, 1.0);
    var end = Offset.zero;
    var curve = Curves.ease;
    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

    return SlideTransition(position: animation.drive(tween), child: child);
  }
}
