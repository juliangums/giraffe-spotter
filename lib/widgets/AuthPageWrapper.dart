import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/Styles.dart';

class AuthPageWrapper extends StatelessWidget {
  const AuthPageWrapper({
    required this.child,
    this.bottomNavigation,
    this.leading,
    this.actions,
    this.title,
    this.drawer,
    this.bannerTitle,
    this.bannerCaption,
    this.expandHeight,
    Key? key,
  }) : super(key: key);
  final Widget child;
  final Widget? bottomNavigation, drawer;
  final String? title, bannerTitle, bannerCaption;
  final Widget? leading;
  final List<Widget>? actions;
  final double? expandHeight;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBodyBehindAppBar: true,
      key: key,
      drawer: drawer,
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            backwardsCompatibility: false,
            systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.dark, statusBarColor: Colors.transparent),
            leading: leading,
            title: Text(
              title!,
              style: Styles.appBarTitle,
            ),
            centerTitle: true,
            elevation: 0,
            forceElevated: false,
            floating: false,
            backgroundColor: Colors.transparent,
            // flexibleSpace: Placeholder(),
            flexibleSpace: Container(
              color: Palette.bannerColor,
              width: width,
              child: Stack(
                children: [
                  Positioned(
                    top: 10,
                        child: Transform.scale(
                         scale: 1.31,
                         child: Container(
                           height: 350,
                            child: Image.asset(Assets.authBanner)
                        ),
                      )
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 104),
                      Container(
                        padding: EdgeInsets.only(left: 26.5),
                        child: Text(bannerTitle!, style: Styles.bannerTitle.copyWith(height: 1.28)
                        ),
                      ),
                      SizedBox(height: 12),
                      Container(
                        padding: EdgeInsets.only(left: 26),
                        child: Text(bannerCaption!, style: Styles.bannerSubTitle),
                      )
                    ],
                  ),
                ],
              ),
            ),
            expandedHeight: expandHeight!,
            pinned: true,
            iconTheme: IconThemeData(
              color: Palette.primaryTextColor, //change your color here
            ),
            actions: actions,
          ),
          SliverToBoxAdapter(
            child: child,
          )
        ],
      ),
      bottomNavigationBar: bottomNavigation,
    );
  }
}
