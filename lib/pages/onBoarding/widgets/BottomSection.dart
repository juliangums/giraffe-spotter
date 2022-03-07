import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/blocs/on_boarding/PageCubit.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/pages/authentication/Login.dart';
import 'package:giraffe_spotter/pages/onBoarding/widgets/NextButton.dart';
import 'package:giraffe_spotter/utils/SharedObjects.dart';
import 'package:giraffe_spotter/widgets/LargeButton.dart';
import 'package:giraffe_spotter/widgets/PageIndicator.dart';

class BottomSection extends StatelessWidget {
  final int index;

  const BottomSection({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return Container(
      height: height / 4.77,
      color: Palette.primaryColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: List.generate(3, (_) => PageIndicator(_ == index))),
          index <= 1
              ? Padding(
                  padding: const EdgeInsets.only(left: 55, right: 38, top: 38),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(onTap: () => context.read<PageCubit>().jumpToLast(),key:Key('skip'), child: Text('skip', style: Styles.onBoardSkip)),
                      NextButton(index: index),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 38.0),
                  child: LargeButtonReplacement(
                    title: 'Get started',
                    wrapperMargin: EdgeInsets.symmetric(horizontal: 50),
                    onTap: () {
                      //stop welcome page from showing again.
                      SharedObjects.prefs!.setBool('onBoard', true);
                      //nav to login page.
                      locator!<AppRoute>().navigateTo(Login());
                      },
               ),
          )
        ],
      ),
    );
  }
}
