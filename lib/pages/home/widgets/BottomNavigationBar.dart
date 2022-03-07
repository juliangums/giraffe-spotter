import  'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:giraffe_spotter/blocs/home/BottomBarCubit.dart';
import 'package:giraffe_spotter/blocs/pageWrappers/PageWrap.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BottomNaviBar extends StatelessWidget {
  final int? index;

  const BottomNaviBar({Key? key, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BottomNavigationBar(
        currentIndex: index!,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Palette.accentColor,
        unselectedItemColor: Palette.secondaryTextColor,
        unselectedLabelStyle: Styles.bottomNavigationLabel,
        selectedLabelStyle: Styles.selectedBottomNavigationLabel,
        showUnselectedLabels: true,
        onTap: (int index) => {context.read<BottomBarCubit>().updateIndex(index),context.read<PageWrapCubit>().restoreScroll()},
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: SvgPicture.asset(Assets.InactiveHome,),activeIcon:SvgPicture.asset(Assets.home) , label: 'Home'),
          BottomNavigationBarItem(icon: SvgPicture.asset(Assets.capture), activeIcon: SvgPicture.asset(Assets.ActiveCamera), label: 'Capture '),
          BottomNavigationBarItem(icon: SvgPicture.asset(Assets.heart), activeIcon: SvgPicture.asset(Assets.ActiveHeart), label: 'Favourites'),
          BottomNavigationBarItem(icon: SvgPicture.asset(Assets.info), activeIcon: SvgPicture.asset(Assets.ActiveLearn), label: 'Learn')
        ],
      ),
    );
  }
}