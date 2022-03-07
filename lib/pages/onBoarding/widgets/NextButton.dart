import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/blocs/on_boarding/PageCubit.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/utils/SharedObjects.dart';

class NextButton extends StatelessWidget {
  final index;

  const NextButton({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: Palette.accentColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(vertical: 19, horizontal: 20),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        minimumSize: Size.zero,
      ),
      key:Key('Next'),
      onPressed: () {
        //Stop welcome page from opening again. :)
        SharedObjects.prefs!.setBool('onBoard', true);
        context.read<PageCubit>().updatePageState(index != 3 ? index + 1 : index);
      },
      child: Row(children: [Text('Next', style: Styles.onBoardNext), SizedBox(width: 18), Image.asset(Assets.arrow_left)]),
    );
  }
}
