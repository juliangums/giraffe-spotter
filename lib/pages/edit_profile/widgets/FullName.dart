import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/Decorations.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/Styles.dart';



class FullName extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Full Name',style: Styles.editProfileTopics),
        SizedBox(height: 5),
        TextFormField(
          key:Key('fullName'),
          keyboardType: TextInputType.emailAddress,
          textDirection: TextDirection.ltr,
          textInputAction: TextInputAction.next,
          style: Styles.editProfileInput,
          initialValue: 'Rose Maria',
          cursorWidth: 1.0,
          cursorColor: Palette.accentColor,
          maxLines: 1,
          decoration: Decorations.setUnderlineInputBorder(),
        ),
      ],
    );
  }
}