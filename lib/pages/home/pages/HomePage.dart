import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/blocs/capture/CaptureCubit.dart';
import 'package:giraffe_spotter/blocs/capture/pageCubit/CapturePageCubit.dart';
import 'package:giraffe_spotter/blocs/edit_profile/UpdateProfileCubit.dart';
import 'package:giraffe_spotter/blocs/giraffe_profile/GiraffeProfileCubit.dart';
import 'package:giraffe_spotter/blocs/home/BottomBarCubit.dart';
import 'package:giraffe_spotter/blocs/home/profile/GiraffeFavCubit.dart';
import 'package:giraffe_spotter/blocs/on_boarding/PageCubit.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/pages/capture/CapturePage.dart';
import 'package:giraffe_spotter/pages/favourite/FavouritePage.dart';
import 'package:giraffe_spotter/pages/home/widgets/BottomNavigationBar.dart';
import 'package:giraffe_spotter/pages/learn/About.dart';
import 'package:giraffe_spotter/pages/menu/MenuPage.dart';
import 'package:giraffe_spotter/providers/CaptureProvider.dart';
import 'package:giraffe_spotter/providers/FavouriteProvider.dart';
import 'package:giraffe_spotter/repositories/GiraffeProfileRepository.dart';
import 'package:giraffe_spotter/repositories/UpdateProfileRepository.dart';
import 'package:giraffe_spotter/widgets/PageWrapper.dart';

import 'Home.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CaptureCubit(CaptureProvider())),
        BlocProvider(create: (context) => UpdateProfileCubit(UpdateProfileRepository())),
        BlocProvider(create: (context) => GiraffeFavCubit(initialValue: 1, favouriteProvider: FavouriteProvider())..favourites()),
        BlocProvider(create: (context) => GiraffeProfileCubit(repository: GiraffeProfileRepository())),
        BlocProvider(create: (context) => PageCubit(initialPage: 0)),
        BlocProvider(create: (context) => CapturePageCubit(initialPage: 0)),
      ],
      child: BlocBuilder<BottomBarCubit, int>(builder: (context, state) {
        return PageWrapper(
          titleBuilder: state == 1
              ? BlocBuilder<CapturePageCubit, int>(builder: (context, state) {
                  return Row(children: [
                    SizedBox(width: MediaQuery.of(context).size.width / 9.3),
                    Text(context.read<CapturePageCubit>().title, style: Styles.appBarTitle),
                  ]);
                })
              : Text(''),
          leading: state == 1 ? InkWell() : null,
          actions: [
            state == 1
                ? SizedBox()
                : Padding(
                    padding: EdgeInsets.only(right: 29),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 24, width: 24, child: Image.asset(Assets.splashIcon, fit: BoxFit.contain)),
                        SizedBox(width: MediaQuery.of(context).size.width * 0.377),
                      ],
                    ),
                  ),
          ],
          drawer: ClipRRect(
            borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomRight: Radius.circular(10)),
            child: Container(width: width / 1.145, child: Drawer(child: MenuPage())),
          ),
          child: Container(
              child: state == 0
                  ? Home()
                  : state == 1
                      ? CapturePage()
                      : state == 2
                          ? FavouritePage()
                          : state == 3
                              ? AboutPage()
                              : null),
          bottomNavigation: BottomNaviBar(index: state),
        );
      }),
    );
  }
}
