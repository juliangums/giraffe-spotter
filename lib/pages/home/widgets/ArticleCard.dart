import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Decorations.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/models/Item.dart';
import 'package:giraffe_spotter/pages/home/pages/ArticlePage.dart';
import 'package:giraffe_spotter/utils/XmlHandler.dart';
import 'package:giraffe_spotter/widgets/ImageWidget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:xml/xml.dart';

class ArticleCard extends StatelessWidget {
  final Item itemData;
  final bool page;

  ArticleCard({required this.itemData, required this.page});

  _launchURL(String _url) async => await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        //handles errors which occur...
        XmlHandler.xmlResponse(itemData.encoded.t) is XmlDocument
            // && !itemData.link.t.toString().contains('https://giraffeconservation.org/2021/09/30/update-october-2021/')
            ? locator!<AppRoute>().navigateTo(ArticlePage(itemData: itemData))
            : _launchURL(itemData.link.t.toString());
      },
      child: Container(
        width: 148,
        key: Key('articleCard${2.toString()}'),
        decoration: Decorations.cardSliderDecoration(),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                child: Container(
                  child: ImageWidget(
                    image: XmlHandler.firstDecode(itemData.encoded.t.toString()),
                    page: false,
                  ),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        XmlHandler.timeDuration(itemData.pubDate.t.toString(), true),
                        style: Styles.cardTimeText,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          itemData.title.t.toString(),
                          style: Styles.cardSlideTitle,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                  page
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 4),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Palette.shimmerColor1.withOpacity(0.9)),
                                      borderRadius: BorderRadius.circular(5)),
                                  child: Text(
                                    page ? itemData.category.t.toString() : itemData.creator.t.toString(),
                                    style: Styles.cardCategoryText.copyWith(color: Palette.secondaryTextColor),
                                    overflow: TextOverflow.ellipsis,
                                  )),
                            )
                          ],
                        )
                      : Row(children: [
                          Text(
                            "By: ",
                            style: Styles.cardCategoryText.copyWith(color: Palette.secondaryTextColor),
                          ),
                          Flexible(
                              child: Text(
                            page ? itemData.category.t.toString() : itemData.creator.t.toString(),
                            style: Styles.cardCategoryText.copyWith(color: Palette.secondaryTextColor.withOpacity(0.5)),
                            overflow: TextOverflow.ellipsis,
                          ))
                        ]),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
