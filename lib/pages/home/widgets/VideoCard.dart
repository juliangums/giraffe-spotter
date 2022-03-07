import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Decorations.dart';
import 'package:giraffe_spotter/config/Styles.dart';

class VideoCard extends StatelessWidget {
  final String? image, cardTitle, time;
  final int index;
  final onTapVideo;
  VideoCard({this.image, this.index = 3, this.cardTitle, this.time, this.onTapVideo});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 148,
      decoration: Decorations.cardSliderDecoration(),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: InkWell(
                key: Key('videoItem${index.toString()}'),
                onTap: onTapVideo!,
                child: Container(
                  child: Center(
                    child: SvgPicture.asset(Assets.videoIcon),
                        ),
                    decoration: BoxDecoration(image: DecorationImage(image: NetworkImage('$image'), fit: BoxFit.fill)),
                ),
              ),
            ),
          ),
          Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '',
                            style: Styles.cardTimeText,
                          )
                        ],
                      ),
                    ),
                    Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Text(
                              '$cardTitle',
                              style: Styles.cardSlideTitle,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
