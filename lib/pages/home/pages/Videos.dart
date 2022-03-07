import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/blocs/videos/VideoCubit.dart';
import 'package:giraffe_spotter/blocs/videos/VideoState.dart';
import 'package:giraffe_spotter/blocs/videos/video_search/VideoSearchCubit.dart';
import 'package:giraffe_spotter/blocs/videos/video_search/VideoSearchState.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/models/YoutubeVideo.dart';
import 'package:giraffe_spotter/pages/home/widgets/CardSlide.dart';
import 'package:giraffe_spotter/pages/home/widgets/LoadingArticles.dart';
import 'package:giraffe_spotter/pages/home/widgets/Search.dart';
import 'package:giraffe_spotter/pages/home/widgets/YoutubeVideoPlayer.dart';
import 'package:giraffe_spotter/utils/Extensions.dart';
import 'package:giraffe_spotter/widgets/ArrowBackButton.dart';
import 'package:giraffe_spotter/widgets/PageWrapper.dart';

class VideoViewer extends StatefulWidget {
  @override
  VideoViewing createState() => VideoViewing();
}

class VideoViewing extends State<VideoViewer> {
  @override
  Widget build(BuildContext context) {
    return PageWrapper(
      title: "Videos",
      leading: ArrowBackButton(),
      child: BlocBuilder<VideoCubit, VideoState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          if (state is LoadingState) {
            return LoadingPage();
          } else if (state is ErrorState) {
            return state.error!.maybeWhen(
              noInternetConnection: () => LoadingPage(),
              orElse: () => Container(),
            );
          } else if (state is LoadedState) {
            return BlocProvider(
                create: (context) => VideoSearchCubit(videoItems: state.videos),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SearchField(videoList: state.videos, diffSearch: 'video'),
                      BlocBuilder<VideoSearchCubit, VideoSearchState>(builder: (context, searchState) {
                        return videoResultPicker(context, searchState);
                      }),
                      SizedBox(height:10),
                    ],
                  ),
                ));
          } else {
            Container();
          }
          return Container();
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown, DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }
}

StatelessWidget videoResultPicker(BuildContext context, VideoSearchState state) {
  if (state is ErrorSearchState) {
    return Container();
  } else if (state is LoadingSearchState) {
    return LoadingPage();
  } else if (state is LoadedSearchState) {
    return VideoView(state.videoItems);
  } else {
    return Container();
  }
}

class VideoView extends StatelessWidget {
  final List<Video>? videos;

  VideoView(this.videos);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(vertical: 34, horizontal: 5),
      itemCount: videos!.length,
      itemBuilder: (context, index) {
        final video = videos![index];
        return CardSlide(
            cardTitle: video.title,
            time: DateTime.parse(video.publishedAt!).timeago(),
            video: true,
            image: video.thumbnailUrl,
            onTap: () => locator!<AppRoute>().navigateTo(YoutubeVideoPlayer(videoId: video.id)));
      },
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 18, childAspectRatio: 0.85),
    );
  }
}
