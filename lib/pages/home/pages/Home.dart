import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/blocs/giraffe_profile/GiraffeProfileCubit.dart';
import 'package:giraffe_spotter/blocs/giraffe_profile/GiraffeProfileState.dart';
import 'package:giraffe_spotter/blocs/home/articles/ArticleBloc.dart';
import 'package:giraffe_spotter/blocs/home/articles/ArticleState.dart';
import 'package:giraffe_spotter/blocs/home/profile/GiraffeFavCubit.dart';
import 'package:giraffe_spotter/blocs/videos/VideoCubit.dart';
import 'package:giraffe_spotter/blocs/videos/VideoState.dart' as Video;
import 'package:giraffe_spotter/blocs/videos/VideoState.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/models/GiraffeData.dart';
import 'package:giraffe_spotter/models/WelcomeJson.dart';
import 'package:giraffe_spotter/pages/home/pages/ProfileGrid.dart';
import 'package:giraffe_spotter/pages/home/pages/Videos.dart';
import 'package:giraffe_spotter/pages/home/widgets/ArticleCard.dart';
import 'package:giraffe_spotter/pages/home/widgets/CardSlide.dart';
import 'package:giraffe_spotter/pages/home/widgets/SliderHeader.dart';
import 'package:giraffe_spotter/pages/home/widgets/YoutubeVideoPlayer.dart';
import 'package:giraffe_spotter/repositories/GiraffeProfileRepository.dart';
import 'package:giraffe_spotter/utils/Extensions.dart';
import 'package:giraffe_spotter/widgets/LoadingWidget.dart';

import 'Articles.dart';
import 'GiraffeProfile.dart';

class Home extends StatelessWidget {
  GiraffeProfileRepository repository = GiraffeProfileRepository();
  ContainerTransitionType _transitionType = ContainerTransitionType.fadeThrough;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(children: [
            SliderHeader(
              title: "Giraffe",
              action: () async {
                final bool = await locator!<AppRoute>().navigateTo(ProfileGrid());
                if (bool == true) {
                  context.read<GiraffeProfileCubit>().getGiraffes(true);
                  context.read<GiraffeFavCubit>().favourites();
                }
              },
              keyString: 'profileGrid',
            ),
            SizedBox(height: 18),
          ]),
        ),
        LimitedBox(
          maxHeight: MediaQuery.of(context).size.height / 3.80,
          child: BlocBuilder<GiraffeProfileCubit, GiraffeProfileState>(
            builder: (context, state) {
              if (state is GiraffeLoadingState) {
                return LoadingListWidget();
              } else if (state is GiraffeErrorState) {
                return LoadingListWidget();
              } else if (state is GiraffeLoadedState) {
                final List<GiraffeData> giraffes = state.giraffeProfiles!;
                return state.giraffeProfiles != null && state.giraffeProfiles!.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.only(left: 24, top: 3),
                        scrollDirection: Axis.horizontal,
                        itemCount: giraffes.length > 5 ? 5 : giraffes.length,
                        itemBuilder: (context, index) {
                          final giraffe = giraffes[index];
                          return OpenContainer<bool>(
                            transitionType: _transitionType,
                            openBuilder: (BuildContext _, VoidCallback openContainer) {
                              return GiraffeProfilePage(
                                giraffeData: giraffe,
                                fav: giraffe.favourite,
                              );
                            },
                            tappable: true,
                            onClosed: (type) => {
                              if (type == true)
                                {context.read<GiraffeProfileCubit>().getGiraffes(true), context.read<GiraffeFavCubit>().favourites()}
                            },
                            closedShape: const RoundedRectangleBorder(),
                            closedElevation: 0.0,
                            closedBuilder: (BuildContext _, VoidCallback openContainer) {
                              return Padding(
                                padding: EdgeInsets.only(right: 24, bottom: 5),
                                child: CardSlide(
                                  cardTitle: giraffe.nickname,
                                  imageType: true,
                                  image: giraffe.encounters[0].annotations[0].media[0].image_url,
                                  locationName: giraffe.encounters[0].locality,
                                  sex: giraffe.sex,
                                  fav: giraffe.favourite,
                                ),
                              );
                            },
                          );
                        })
                    : LoadingListWidget();
              } else {
                return Container();
              }
            },
          ),
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                SizedBox(height: 20),
                SliderHeader(
                  title: "Videos",
                  action: () => locator!<AppRoute>().navigateTo(VideoViewer()),
                  keyString: 'Videos',
                ),
                SizedBox(height: 18),
              ],
            )),
        LimitedBox(
          maxHeight: MediaQuery.of(context).size.height / 3.80,
          child: BlocBuilder<VideoCubit, Video.VideoState>(
            builder: (context, state) {
              if (state is Video.LoadingState) {
                return LoadingListWidget();
              } else if (state is ErrorState) {
                return LoadingListWidget();
              } else if (state is Video.LoadedState) {
                final videos = state.videos;
                return ListView.builder(
                  shrinkWrap: true,
                  padding: EdgeInsets.only(left: 24, top: 3, bottom: 1),
                  scrollDirection: Axis.horizontal,
                  itemCount: videos.length > 5 ? 5 : videos.length,
                  itemBuilder: (context, index) {
                    final video = videos[index];
                    return OpenContainer<bool>(
                      transitionType: _transitionType,
                      openBuilder: (BuildContext _, VoidCallback openContainer) {
                        return YoutubeVideoPlayer(videoId: video.id);
                      },
                      tappable: true,
                      closedShape: const RoundedRectangleBorder(),
                      closedElevation: 0.0,
                      closedBuilder: (BuildContext _, VoidCallback openContainer) {
                        return Padding(
                          padding: EdgeInsets.only(right: 24, bottom: 5),
                          child: CardSlide(
                            video: true,
                            time: DateTime.parse(video.publishedAt!).timeago(),
                            cardTitle: video.title,
                            image: video.thumbnailUrl,
                          ),
                        );
                      },
                    );
                  },
                );
              } else {
                return Container();
              }
            },
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 20),
              SliderHeader(
                title: "Articles",
                action: () => locator!<AppRoute>().navigateTo(Articles()),
                keyString: 'Articles',
              ),
              SizedBox(height: 18),
            ],
          ),
        ),
        LimitedBox(
          maxHeight: MediaQuery.of(context).size.height / 3.80,
          child: BlocBuilder<ArticleBloc, ArticleState>(
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              return state.maybeWhen(
                  loading: () => LoadingListWidget(),
                  idle: () => LoadingListWidget(),
                  getFeedDone: (WelcomeJson data) => ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.only(left: 24, top: 3, bottom: 5),
                      scrollDirection: Axis.horizontal,
                      itemCount: data.rss.channel.item.length > 5 ? 5 : data.rss.channel.item.length,
                      itemBuilder: (context, index) {
                        final giraffe = data.rss.channel.item[index];
                        return Padding(
                          padding: EdgeInsets.only(right: 24.0, bottom: 3),
                          child: ArticleCard(itemData: giraffe, page: false),
                        );
                      }),
                  orElse: () => LoadingListWidget());
            },
          ),
        ),
        SizedBox(height: 30),
      ],
    );
  }
}
