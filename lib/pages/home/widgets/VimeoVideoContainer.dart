import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/pages/home/widgets/YoutubeVideoPlayer.dart';
import 'package:giraffe_spotter/widgets/ImageWidget.dart';

class VimeoVideoContainer extends StatelessWidget {

  final String title;
  final String id;

  const VimeoVideoContainer({required this.title, required this.id});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => locator!<AppRoute>().navigateTo(YoutubeVideoPlayer(vimeoId: id, youtube: false)),
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
                    child: Container (
                      height:150,
                      child: ImageWidget (
                        image: "https://vumbnail.com/$id.jpg",
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
              title,
              style: Styles.articleBodyText.copyWith(color: Palette.primaryTextColor.withOpacity(0.6), fontSize: 12),
              overflow: TextOverflow.clip,
            ),
          )
        ],
      ),
    );
  }
}