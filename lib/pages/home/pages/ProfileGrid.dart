import 'dart:io';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frefresh/frefresh.dart';
import 'package:giraffe_spotter/blocs/filterGiraffes/FilterCubit.dart';
import 'package:giraffe_spotter/blocs/filterGiraffes/FilterState.dart';
import 'package:giraffe_spotter/blocs/giraffe_profile/FilterGiraffesCubit.dart';
import 'package:giraffe_spotter/blocs/giraffe_profile/FliterGiraffesState.dart';
import 'package:giraffe_spotter/blocs/giraffe_profile/GiraffeProfileCubit.dart';
import 'package:giraffe_spotter/blocs/giraffe_profile/GiraffeProfileState.dart';
import 'package:giraffe_spotter/blocs/giraffe_profile/giraffe_fav/FavouriteCubit.dart';
import 'package:giraffe_spotter/blocs/giraffe_profile/giraffe_fav/FavouriteState.dart';
import 'package:giraffe_spotter/blocs/videos/VideoState.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/models/GiraffeData.dart';
import 'package:giraffe_spotter/pages/favourite/widgets/Filter.dart';
import 'package:giraffe_spotter/pages/home/widgets/CardSlide.dart';
import 'package:giraffe_spotter/pages/home/widgets/LoadingArticles.dart';
import 'package:giraffe_spotter/providers/FilterProvider.dart';
import 'package:giraffe_spotter/repositories/GiraffeProfileRepository.dart';
import 'package:giraffe_spotter/widgets/PageWrapper.dart';

import 'GiraffeProfile.dart';

class ProfileGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GiraffeProfileRepository repository = GiraffeProfileRepository();
    FRefreshController controller = FRefreshController();
    List<GiraffeData> giraffes = [];
    final height = MediaQuery.of(context).size.height;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GiraffeProfileCubit(repository: repository)),
        BlocProvider(create: (context) => FilterGiraffesCubit(repository)),
        BlocProvider(create: (context) => FilterCubit(FilterProvider())..getFilterData())
      ],
      child: Material(
        child: BlocBuilder<GiraffeProfileCubit, GiraffeProfileState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              return WillPopScope(
                onWillPop: () => context.read<GiraffeProfileCubit>().backing == true
                    ? locator!<AppRoute>().back(params: true)
                    : locator!<AppRoute>().back(params: false),
                child: PageWrapper(
                  actions: [
                    BlocBuilder<FilterCubit, FilterState>(
                      builder: (context, state) {
                        return GestureDetector(onTap: () => filterFillTable(context, state), child: Image.asset(Assets.filterIcon));
                      },
                    ),
                    SizedBox(width: 20)
                  ],
                  title: 'Search Giraffes',
                  leading: GestureDetector(
                    onTap: () => context.read<GiraffeProfileCubit>().backing == true
                        ? locator!<AppRoute>().back(params: true)
                        : locator!<AppRoute>().back(params: false),
                    child: Padding(
                      padding: EdgeInsets.only(left: 24, right: 10),
                      child: Icon(Platform.isAndroid ? Icons.arrow_back : Icons.arrow_back_ios, color: Palette.dividerColor),
                    ),
                  ),
                  child: BlocBuilder<GiraffeProfileCubit, GiraffeProfileState>(
                    buildWhen: (previous, current) => previous != current,
                    builder: (context, state) {
                      if (state is GiraffeLoadingState && state.isFirstFetch) {
                        return LoadingPage(search: true);
                      } else if (state is GiraffeLoadedState || state is GiraffeLoadingState) {
                        if (state is GiraffeLoadedState) {
                          giraffes = state.giraffeProfiles!;
                        } else if (state is GiraffeLoadingState) {
                          giraffes = state.oldGiraffeProfile;
                        }
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              BlocBuilder<FilterGiraffesCubit,
                                  FilterGiraffesState>(
                                builder: (context, filterState) {
                                  return ConstrainedBox(
                                    constraints: BoxConstraints.expand(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.9),
                                    child: FRefresh(
                                      controller: controller,
                                      onLoad: () {
                                        if (state is LoadedState) {
                                          controller.finishLoad();
                                        }
                                      },
                                      footerBuilder: (setter) {
                                        /// Get refresh status, partially update the content of Footer area
                                        controller
                                            .setOnStateChangedCallback((state) {
                                          setter(() {
                                            if (controller.loadState ==
                                                LoadState.PREPARING_LOAD) {
                                              context
                                                  .read<GiraffeProfileCubit>()
                                                  .getGiraffes(false);
                                            } else if (controller.loadState ==
                                                    LoadState.LOADING &&
                                                state is LoadingState) {
                                              _loadingIndicator();
                                            } else if (controller.loadState ==
                                                    LoadState.FINISHING &&
                                                state is LoadedState) {
                                              controller.finishLoad();
                                            } else {}
                                          });
                                        });
                                        return _loadingIndicator();
                                      },
                                      footerHeight: height * 0.18,
                                      child: resultPicker(
                                          context, filterState, giraffes),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
              );
            }),
      ),
    );
  }

  StatelessWidget resultPicker(BuildContext context, FilterGiraffesState state, initialGiraffes) {
    if (state.filteredGiraffes != null) {
      return Container(
        child: Column(
          children: [
            ViewGrid(giraffes: state.filteredGiraffes),
          ],
        ),
      );
    } else {
      return Container(
        child: Column(
          children: [
            ViewGrid(giraffes: initialGiraffes),
          ],
        ),
      );
    }
  }

  //builds the Bottom dialog
  filterFillTable(BuildContext _, FilterState fState) {
    showModalBottomSheet(
      context: _,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10.0))),
      builder: (context) => BlocProvider.value(
        value: BlocProvider.of<GiraffeProfileCubit>(_),
        child: BlocProvider(
          create: (context) => FilterGiraffesCubit(GiraffeProfileRepository())..accesStore(),
          child: Filter(
            fState: fState,
          ),
        ),
      ),
    );
  }
}

Widget _loadingIndicator() {
  return Padding (
    padding: const EdgeInsets.all(8.0),
    child: Center(
        child: LinearProgressIndicator(
      color: Palette.accentColor,
      backgroundColor: Palette.bodyBackgroundColor,
    )),
  );
}

class ViewGrid extends StatelessWidget {
  ViewGrid({this.giraffes});

  final List<GiraffeData>? giraffes;

  @override
  Widget build(BuildContext context) {
    return giraffes!.length > 0 ? BlocProvider(
            create: (context) => FavouriteCubit(data: [], removed: []),
            child: BlocBuilder<FavouriteCubit, FavouriteState>(
              buildWhen: (prev, current) => prev != current,
              builder: (context, state) => GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(vertical: 14, horizontal: 2),
                itemCount: giraffes?.length ?? 0,
                itemBuilder: (context, index) {
                  final giraffe = giraffes![index];
                  (giraffe.favourite == true && !state.giraffeDet.contains(index)) ? context.read<FavouriteCubit>().addFav(index) : {};
                  return giraffes!.length != 0
                      ? OpenContainer<bool>(
                          transitionType: ContainerTransitionType.fadeThrough,
                          openBuilder: (BuildContext _, VoidCallback openContainer) {
                            return GiraffeProfilePage(
                              giraffeData: giraffe,
                              indexes: index,
                              favState: state,
                              fav: (state.giraffeFav != null && state.giraffeFav!.contains(index))
                                  ? true
                                  : state.giraffeDet.contains(index)
                                      ? false
                                      : giraffe.favourite,
                            );
                          },
                          tappable: true,
                          onClosed: (change) => {
                            if (change == false)
                              {
                                context.read<FavouriteCubit>().addFav(index),
                                context.read<GiraffeProfileCubit>().backing = true,
                              },
                            if (state.giraffeFav != null && state.giraffeFav!.contains(index) && change == true)
                              {
                                context.read<FavouriteCubit>().remove(index),
                                context.read<GiraffeProfileCubit>().backing = true,
                              }
                          },
                          closedShape: const RoundedRectangleBorder(),
                          closedElevation: 0.0,
                          closedBuilder: (BuildContext _, VoidCallback openContainer) {
                            return Padding(
                                padding: EdgeInsets.only(right: 5, bottom: 5),
                                child: CardSlide(
                                  cardTitle: giraffe.nickname,
                                  imageType: true,
                                  image: giraffe.encounters[0].annotations.length == 0
                                      ? ''
                                      : giraffe.encounters[0].annotations[0].media[0].image_url,
                                  locationName: giraffe.encounters[0].locality,
                                  sex: giraffe.sex,
                                  fav: (state.giraffeFav != null && state.giraffeFav!.contains(index))
                                      ? true
                                      : state.giraffeDet.contains(index)
                                          ? false
                                          : giraffe.favourite,
                                ));
                          },
                        )
                      : Container();
                },
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 25,
                  mainAxisSpacing: 13,
                  childAspectRatio: 0.73,
                ),
              ),
            ),
          ) : Container(
            height: 150,
            child: Center(
              child: Text(
                'No Giraffe profile found.',
                style: Styles.filterData.copyWith(color: Palette.primaryTextColor),
              ),
            ),
          );
  }
}
