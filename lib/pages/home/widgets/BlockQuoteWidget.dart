import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/Styles.dart';


class BlockQuoteWidget extends StatelessWidget{

  final String text;

  BlockQuoteWidget({required this.text});


  @override
  Widget build(BuildContext context) {

    return ListTile(
      leading: Container(
        child: VerticalDivider(thickness: 3,color: Palette.accentColor),),
      title: Text(text,style: Styles.articleBodyText.copyWith(fontFamily: 'Poppins-SemiBold',color: Palette.primaryTextColor.withOpacity(.8)),),
    );
  }
}