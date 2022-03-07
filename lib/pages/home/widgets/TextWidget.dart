import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/Styles.dart';

class TextWidget extends StatelessWidget{

  final String textDisplay;
  final String xmlTag;

  TextWidget({required this.textDisplay,required this.xmlTag});

  @override
  Widget build(BuildContext context) {
        return Container(
          padding: EdgeInsets.only(bottom: xmlTag != 'p' ? 10 : 0),
          child: Text( xmlTag == 'li' ? '-'+ textDisplay:textDisplay,
            style:xmlTag != 'p' && xmlTag != 'li'? Styles.articleBodyText.copyWith(fontFamily: 'Poppins-SemiBold',decoration: TextDecoration.underline,color: Palette.primaryTextColor.withOpacity(.8)):
            Styles.articleBodyText,
          ),
        );
  }
}