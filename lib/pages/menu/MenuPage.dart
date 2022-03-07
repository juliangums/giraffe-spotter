import 'dart:io';

import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Constants.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/pages/menu/widgets/MenuItems.dart';
import 'package:giraffe_spotter/pages/menu/widgets/ProfileDisplay.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.primaryColor,
      body: Column(
        children: [
          SizedBox(height: 60),
          GestureDetector(
            key:Key('backDrawer'),
            onTap: () => locator!<AppRoute>().back(),
            child: Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.only(left: 16.0),
              child: Icon(Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios),
            ),
          ),
          ProfileDisplay(),
          SizedBox(height: 40),
          ListView.builder(
            itemCount: Constants.drawerItems.sublist(0, 3).length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => DelayedDisplay(
              delay: Duration(milliseconds: (10 * index + 1)),
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: MenuItems(icon: Constants.drawerItems[index]['icon'], title: Constants.drawerItems[index]['title']),
              ),
              slidingBeginOffset: Offset(1.0, 0.0),
            ),
          ),
          Spacer(),
          ListView.builder(
            itemCount: Constants.drawerItems.skip(3).length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => DelayedDisplay(
              delay: Duration(milliseconds: (40 * index + 1)),
              child: Padding(
                padding: EdgeInsets.only(left: index == 0 ? 12 : 10.0),
                child: MenuItems(icon: Constants.drawerItems.skip(3).toList()[index]['icon'], title: Constants.drawerItems.skip(3).toList()[index]['title']),
              ),
              slidingBeginOffset: Offset(0.0, -1.0),
            ),
          ),
          SizedBox(height: 40),
        ],
      ),
    );
  }
}
