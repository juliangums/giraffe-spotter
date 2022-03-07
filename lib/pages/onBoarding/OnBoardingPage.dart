import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/blocs/on_boarding/PageCubit.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/pages/onBoarding/widgets/BottomSection.dart';
import 'package:giraffe_spotter/pages/onBoarding/widgets/ScreenPage.dart';

class OnBoardingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PageCubit(initialPage: 0),
      child: BlocBuilder<PageCubit, int>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Palette.primaryColor,
            body: Column(
              children: [
                Expanded(
                  child: Container(
                    child: PageView.builder(
                      itemBuilder: (context, index) => ScreenPage(index: index),
                      itemCount: 3,
                      physics: ClampingScrollPhysics(),
                      controller: context.read<PageCubit>().pageController,
                      onPageChanged: (page) => context.read<PageCubit>().updatePageState(page),
                    ),
                  ),
                ),
                BottomSection(index: state)
              ],
            ),
          );
        },
      ),
    );
  }
}
