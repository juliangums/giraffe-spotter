import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/pages/home/widgets/TopPageCurve.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Size get preferredSize => AppBar().preferredSize;
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  CustomAppBar({Key? key, this.leading, this.actions, this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.transparent),
      child: Stack(
        children: [
          TopPageCurve(),
          AppBar(
            systemOverlayStyle: SystemUiOverlayStyle(statusBarColor: Colors.white),
            leading: leading,
            title: Text(
              title!,
              style: Styles.appBarTitle,
            ),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            actions: actions,
          ),
        ],
      ),
    );
  }
}
