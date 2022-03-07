import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/Styles.dart';

import 'SpinKitFadingCircle.dart';

class LargeButton extends StatelessWidget {
  final String title;
  final double widthSize;
  final double heightSize;
  final VoidCallback onTap;

  const LargeButton({Key? key, required this.title, required this.onTap, required this.widthSize, required this.heightSize})
      : super(key: key);

  @override
  Widget build(BuildContext _) {
    return Padding(
      key:Key('largeDeprecated'),
      padding: EdgeInsets.only(left: widthSize, right: widthSize),
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(height: heightSize),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Palette.accentColor,
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: onTap,
          child: Center(child: Text(title, style: Styles.onBoardNext)),
        ),
      ),
    );
  }
}

class LargeButtonReplacement extends StatelessWidget{
  final String title;
  final VoidCallback onTap;
  final EdgeInsets? wrapperMargin;
  final bool active;
  final bool loading;

  const LargeButtonReplacement({Key? key,this.active = true,this.loading = false, required this.title, required this.onTap, this.wrapperMargin}) : super(key: key);

  @override
  Widget build(BuildContext _) {
    return Container(
      width: double.infinity,
      margin: wrapperMargin,
      child: ElevatedButton(
        key:Key('largeButton'),
        style: ElevatedButton.styleFrom(
          primary: active == true ? Palette.accentColor : Palette.shimmerColor2,
          elevation: 4,
          padding: EdgeInsets.symmetric(vertical: loading == true ?9:17),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),),
        onPressed: onTap,
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 2),
          child: loading == true ? Container(padding:EdgeInsets.only(top:12), child: SpinKitFadingCircle(color: Palette.primaryColor, size: 25))
              :Text(title, style: Styles.onBoardNext)
        )
        // loading == false ? Text(title, style: Styles.onBoardNext):,
      ),
    );
  }
}
