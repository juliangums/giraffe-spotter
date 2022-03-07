import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/blocs/giraffe_profile/GiraffeProfileCubit.dart';
import 'package:giraffe_spotter/blocs/home/profile/GiraffeFavCubit.dart';
import 'package:giraffe_spotter/blocs/home/profile/GiraffeFavState.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/pages/home/pages/GiraffeProfile.dart';
import 'package:giraffe_spotter/pages/home/widgets/CardSlide.dart';
import 'package:giraffe_spotter/pages/home/widgets/LoadingArticles.dart';

class FavouritePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GiraffeFavCubit, GiraffeFavState>(
      builder: (context, state) {
        return state.status.isSubmissionSuccess
            ? state.favouritesGiraffes!.isNotEmpty
                ? SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: 24),
                          CustomScrollView(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            slivers: [
                              CupertinoSliverRefreshControl(onRefresh: () => BlocProvider.of<GiraffeFavCubit>(context).favourites()),
                              SliverGrid(
                                delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
                                  final giraffes = state.favouritesGiraffes![index];
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: 5, top: 5),
                                    child: CardSlide(
                                      cardTitle: giraffes.nickname,
                                      imageType: true,
                                      image: giraffes.encounters[0].annotations.firstOrNull?.media[0].image_url == null
                                          ? ''
                                          : giraffes.encounters[0].annotations[0].media[0].image_url,
                                      locationName: giraffes.encounters[0].locality,
                                      sex: giraffes.sex,
                                      favourite: true,
                                      onTap: () async {
                                        final bool type =
                                            await locator!<AppRoute>().navigateTo(GiraffeProfilePage(fav: true, giraffeData: giraffes));
                                        if (type == true) {
                                          context.read<GiraffeFavCubit>().favourites();
                                          context.read<GiraffeProfileCubit>().getGiraffes(true);
                                        }
                                      },
                                    ),
                                  );
                                }, childCount: state.favouritesGiraffes!.length),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2, mainAxisSpacing: 20.0, crossAxisSpacing: 26.0, childAspectRatio: 0.72),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: EdgeInsets.all(51),
                          child: SvgPicture.asset(Assets.emptyFavorite),
                        ),
                        Text(
                          "No Favorites",
                          style: Styles.appBarTitle,
                        ),
                        SizedBox(height: 12),
                        Text(
                          "You have no favorites saved.",
                          style: Styles.deleteAccountDetails,
                        )
                      ],
                    ),
                  )
            : state.status.isSubmissionInProgress
                ? LoadingPage(search: true)
                : Container(padding: EdgeInsets.symmetric(vertical: 10), child: Center(child: Text('Error occurred')));
      },
    );
  }
}
