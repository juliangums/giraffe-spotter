import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/utils/XmlHandler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/gestures.dart';

class RichTextWidget extends StatelessWidget{
  final String xmlString;
  final Map<String,String> urlLinks;

  RichTextWidget({required this.xmlString, required this.urlLinks});

  @override
  Widget build(BuildContext context) {

    final List<String> finalString = XmlHandler.stringInjector(urlLinks, xmlString);

    return RichText(

        text: TextSpan(
          text: '',
           children: List.generate( finalString.length, (index) =>
            finalString[index].contains('ctrlshiftpgdnpguphome:::') ?
              TextSpan(
                recognizer: TapGestureRecognizer()..onTap =() => _makeUrlCall(urlLinks.values.first.toString()),
               text: finalString[index].replaceFirst('ctrlshiftpgdnpguphome:::', ' ')+" ",
               style: Styles.articleBodyText.copyWith(color: Palette.tertiaryColor)
              )
                : TextSpan(
                  text:finalString[index],
                  style: Styles.articleBodyText
                )
            )
      )
    );
  }

  Future<void> _makeUrlCall(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}