import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:giraffe_spotter/blocs/pageWrappers/PageWrap.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageWrapper extends StatelessWidget {
  PageWrapper(
      {required this.child,this.titleBuilder,this.titleReplacement, this.bottomNavigation, this.leading, this.actions, this.title, this.drawer, this.leadingState, Key? key})
      : super(key: key);
  final Widget child;
  final Widget? bottomNavigation, drawer;
  final String? title;
  final Widget? titleBuilder;
  final Widget? titleReplacement;
  final Widget? leading;
  final List<Widget>? actions;
  final bool? leadingState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: drawer,
        backgroundColor: Colors.white,
        body: CustomScrollView(
          controller: context.read<PageWrapCubit>().controller,
          slivers: <Widget>[
            SliverAppBar(
              backwardsCompatibility: false,
              systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.transparent, statusBarBrightness: Brightness.light),
              leading:Builder(builder: (context)=> GestureDetector(
                key: Key('drawer'),
                onTap: ()=> Scaffold.of(context).openDrawer(),
                child: leading ??
                    Container(
                      color: Colors.transparent,
                      padding: EdgeInsets.only(left: 24, right: 10),
                      child: SvgPicture.asset(Assets.menuIcon),
                    ),
                )
              ),
              title: titleBuilder ?? Text(title!, style: Styles.appBarTitle),
              centerTitle: true,
              elevation: 0,
              forceElevated: false,
              floating: false,
              backgroundColor: Colors.white,
              expandedHeight: 80,
              pinned: true,
              iconTheme: IconThemeData(color: Palette.primaryTextColor),
              actions: actions,
            ),
            SliverToBoxAdapter(child: child)
          ],
        ),
        bottomNavigationBar: bottomNavigation,
      );
  }
}
