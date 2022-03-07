import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:giraffe_spotter/blocs/home/articles/ThumbNail/Bloc.dart';
import 'package:giraffe_spotter/blocs/home/articles/ThumbNail/ThumbNailBloc.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/models/ThumbNail.dart';
import 'package:giraffe_spotter/pages/home/widgets/YoutubeVideoPlayer.dart';
import 'package:giraffe_spotter/repositories/ThumbNailRepository.dart';
import 'package:giraffe_spotter/widgets/ImageWidget.dart';
import 'package:giraffe_spotter/widgets/LoadingWidget.dart';

class YouTubeThumbNailWidget extends StatelessWidget {
  final String image;
  final String videoId;

  const YouTubeThumbNailWidget({Key? key, required this.image, required this.videoId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ThumbNailBloc(context.read<ThumbNailRepository>())..add(ThumbNailEvent.getThumbNail(image)),
      child: BlocBuilder<ThumbNailBloc, ThumbNailState>(
        builder: (context, state) {
          return state.maybeWhen(
            idle: () => LoadingPlaceHolder(),
            loading: () => LoadingPlaceHolder(),
            orElse: () => LoadingPlaceHolder(),
            getThumbNail: (ThumbNail data) => GestureDetector(
              onTap: () => locator!<AppRoute>().navigateTo(YoutubeVideoPlayer(videoId: videoId)),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    padding: EdgeInsets.only(bottom: 10, top: 20),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          child: Container(
                            height:150,
                            child: ImageWidget(
                                image: data.thumbnailUrl,
                                page: false,
                              ),
                          )
                        ),
                        Align(alignment: Alignment.center, child: SvgPicture.asset(Assets.videoIcon))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 15),
                    child: Text(
                      data.title,
                      style: Styles.articleBodyText.copyWith(color: Palette.primaryTextColor.withOpacity(0.6), fontSize: 12),
                      overflow: TextOverflow.clip,
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
