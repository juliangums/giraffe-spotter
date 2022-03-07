import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/pages/delete_account/widgets/ModalInfo.dart';

class ContainModalBottom extends StatelessWidget{

  final BuildContext contextS;
  final bool select;

  const ContainModalBottom({required this.contextS, required this.select});
  @override
  Widget build(BuildContext context) {
    return Wrap(
      runSpacing: 90,
      spacing: 20,
      direction: Axis.vertical,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        SizedBox(height: 3),
        Image.asset(Assets.line),
        select == true ?SvgPicture.asset(Assets.trashDelete) : SizedBox(),
        ModalInfo(context: contextS,select: select,)
      ],
    );
  }
  
}