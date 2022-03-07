import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/Styles.dart';

class SliderHeader extends StatelessWidget {
  final String title;
  final String keyString;
  final action;
  SliderHeader({required this.title,required this.keyString, this.action});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Styles.appBarTitle,
          ),
          InkWell(
            key:Key('${keyString}viewAll'),
            onTap: action,
            child: Container(
              width: 66,
              height: 29,
              margin:EdgeInsets.only(bottom: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Palette.accentColor, width: 0.5),
              ),
              child: Center(
                child: Text(
                  "View All",
                  style: Styles.viewAllTitle,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
