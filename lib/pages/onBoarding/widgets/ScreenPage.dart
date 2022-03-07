import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giraffe_spotter/config/Decorations.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/models/OnBoardData.dart';

class ScreenPage extends StatelessWidget {
  ScreenPage({Key key = const Key("_ScreenPage"), required this.index}) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Container(
      child: Stack(
        children: [
          Container(
            key:Key('ImageContainer'),
            height: height / 2.015,
            width: double.infinity,
            child: SvgPicture.asset(OnBoardData().assetImages[index],fit: BoxFit.fitWidth),
          ),
          Positioned(
            bottom: 1,
            child: Container(
              height: height / 3.29,
              width: MediaQuery.of(context).size.width,
              decoration: Decorations.onBoardingContainersDecoration,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: index != 2 ? height / 18.99 : 19),
                  Text(OnBoardData().topics[index], style: Styles.onBoardTopics),
                  SizedBox(height: 14.5),
                  Padding(
                    padding: const EdgeInsets.only(left: 35.0, right: 38.7),
                    child: Text(OnBoardData().subtopics[index], textAlign: TextAlign.center, style: Styles.onBoardSubTopics),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
