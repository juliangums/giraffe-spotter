import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Decorations.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/widgets/ImageWidget.dart';

class CardSlide extends StatelessWidget {
  final String? image, cardTitle, locationName, time;
  final bool imageType;
  final bool? favourite, fav;
  final bool video;
  final VoidCallback? onTap;
  final int index;
  final String? sex;

  CardSlide(
      {this.image,
      this.index = 3,
      this.imageType = true,
      this.time,
      this.video = false,
      this.onTap,
      this.cardTitle,
      this.locationName,
      this.favourite = false,
      this.fav = false,
      this.sex});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return InkWell(
      key: Key('giraffeIndex${index.toString()}'),
      onTap: onTap,
      child: Container(
        width: 148,
        decoration: Decorations.cardSliderDecoration(),
        child: Column(
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                child: video == false
                    ? imageType == true
                        ? Container(
                            height: height * 0.19,
                            child: ImageWidget(image: image.toString(), page: false),
                          )
                        : Container(
                            height: favourite! ? 165 : 150, width: double.infinity,
                              child: Image.asset(image.toString(), fit: BoxFit.fill)
                )
                    : Container(
                      height: height * 0.16,
                      child: Center(child: SvgPicture.asset(Assets.videoIcon)),
                      decoration: BoxDecoration(image: DecorationImage(image: NetworkImage('$image'), fit: BoxFit.cover)),
                    ),
                ),
            ),
            Container(
              padding: EdgeInsets.only(
                top:  1,
                left: video == false ? 8 : 10,
                right: video == false ? 13 : 10,
                bottom:  10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          video == false ? cardTitle! : time!,
                          style: video == false ? Styles.cardSlideTitle : Styles.cardTimeText,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                  video == false
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.location_on_outlined, color: Palette.accentColor, size: 15),
                            Expanded(
                              child: Text(
                                locationName ?? 'Unknown location',
                                style: Styles.locationTitle,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            favourite! || fav == true
                                ? SvgPicture.asset(Assets.favorite, height: 15, width: 15)
                                : SizedBox(),
                            SizedBox(width: 10),
                                '$sex' == 'male' || '$sex'== 'M' ||'$sex' == 'Male'
                                ? SvgPicture.asset(Assets.maleIcon)
                                :  '$sex' == 'female' || '$sex'== 'F' ||'$sex' == 'Female'
                                    ? SvgPicture.asset(Assets.donation)
                                    : Container()
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                cardTitle ?? '',
                                maxLines: 2,
                                style: Styles.cardSlideTitle,
                                overflow: TextOverflow.fade,
                              ),
                            )
                          ],
                        )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
