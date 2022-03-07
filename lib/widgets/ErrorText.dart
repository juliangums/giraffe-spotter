import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/Styles.dart';

class ErrorText extends StatelessWidget{

  final double left,top,right,bottom;
  final String error;

  ErrorText({this.left = 0,required this.error,this.right = 0,this.top = 0, this.bottom=0});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(left, top, right, bottom),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text( error.isNotEmpty?error:"Data required", style: Styles.dataText.copyWith(color: Colors.red)),
        ],
      ),
    );
  }

}