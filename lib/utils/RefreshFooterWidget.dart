import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/Palette.dart';

class RefreshFooterWidget extends StatelessWidget {
  final Color backgroundColor;
  final Color loaderColor;
  final Color textColor;

  const RefreshFooterWidget(
      {Key? key,
      this.backgroundColor = Palette.accentColor,
      this.loaderColor = Palette.primaryColor,
      this.textColor = Palette.primaryColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 15,
            height: 15,
            child: CircularProgressIndicator(
              backgroundColor: backgroundColor,
              valueColor: new AlwaysStoppedAnimation<Color>(loaderColor),
              strokeWidth: 2.0,
            ),
          ),
          SizedBox(width: 9.0),
          Text('Loading...', style: TextStyle(color: textColor))
        ],
      ),
    );
  }
}
