import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/pages/home/widgets/VimeoVideoContainer.dart';
import 'package:giraffe_spotter/widgets/ImageWidget.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/config/Styles.dart';
import 'package:giraffe_spotter/models/Item.dart';
import 'package:giraffe_spotter/pages/home/widgets/BlockQuoteWidget.dart';
import 'package:giraffe_spotter/pages/home/widgets/RichTextWidget.dart';
import 'package:giraffe_spotter/pages/home/widgets/TextWidget.dart';
import 'package:giraffe_spotter/pages/home/widgets/YouTubeThumbNailWidget.dart';
import 'package:giraffe_spotter/utils/XmlHandler.dart';
import 'package:giraffe_spotter/widgets/ArrowBackButton.dart';
import 'package:giraffe_spotter/widgets/PageWrapper.dart';
import 'package:giraffe_spotter/widgets/ZoomImage.dart';
import 'package:flutter/cupertino.dart';
import 'package:giraffe_spotter/widgets/ShareButton.dart';


// ignore: must_be_immutable
class ArticlePage extends StatelessWidget {

  final Item itemData;
  List<String> xmlCounter = [];
  int i = 0;
  bool image = true;


  ArticlePage({required this.itemData});

  @override
  Widget build(BuildContext context) {
    final List<Map<String,List<String>>> xmlData = XmlHandler.xmlExtractor(itemData.encoded.t,require: true);
    final List<String> xlmElement = XmlHandler.xmlExtractor(itemData.encoded.t,require: true,element: true);
    final List<Map<String,String>> getUrl = XmlHandler.xmlExtractor(itemData.encoded.t,urlLaunch: true);

    return PageWrapper(
      title: "",
      leading: ArrowBackButton(),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 29),
          child: ShareButton(
            shareLink: itemData.link.t,
          ),
        )
      ],
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 29),
        child: SingleChildScrollView(
          child: Wrap(
            spacing:10,
            children: [
              //Image
              ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Container(
                  height:230,
                  child: ImageWidget(
                    image: XmlHandler.firstDecode(itemData.encoded.t.toString()) ,
                    page: false,
                  )
                ),
              ),
              //title && data with topic
              Column(
                  children: [
                    //title
                    Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Flexible(
                        child: Text(
                          itemData.title.t.toString(),
                          style: Styles.cardSlideTitle,
                          overflow: TextOverflow.clip,
                        ),
                      ),
                    ],
                  ),
                    //date and topic
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          XmlHandler.timeDuration(itemData.pubDate.t.toString(),false),
                          style: Styles.cardCategoryText.copyWith(color: Palette.secondaryTextColor.withOpacity(0.5)),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          itemData.creator.t.toString(),
                          style: Styles.cardCategoryText.copyWith(color: Palette.secondaryTextColor),
                        )
                      ],
                    ),
                   ],
              ),
              // Text data display....
              LimitedBox(
                child: ListView.builder(
                    shrinkWrap: true,
                    key: Key('listView'),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: XmlHandler.xmlExtractor(itemData.encoded.t.toString(),require: false),
                    itemBuilder: (BuildContext context, int index){
                      if(xmlCounter.length == (xlmElement.length - 1)){xmlCounter.clear();}
                      i = 0;
                      i = xmlCounter.where((element) => element == xlmElement[index].toString()).length;
                        xmlCounter.add(xlmElement[index].toString());
                     return xmlResults(xlmElement, index,i, xmlData, getUrl);
                  }
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  //determine widget to return based on the XmlNode in the List<String> xlmElement.
  StatelessWidget xmlResults(List<String> element, int index,int xmlIndex,List<Map<String,List<String>>> xmlData,List<Map<String,String>> urlGetter) {
    //return image
    if(element[index].toString()  == 'img') {
      return GestureDetector(
          onTap: ()=> locator!<AppRoute>().navigateTo(ZoomImage(image: xmlData[0][element[index]]![xmlIndex].toString())),
          child: Container(
            padding: EdgeInsets.only(top:10,bottom:10),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
                child: ImageWidget(image:xmlData[0][element[index]]![xmlIndex].toString(), page: true,)),
          )
      );
    }
    //check for the Youtube video
    else if( element[index].toString() == 'p' && xmlData[0][element[index].toString()]![xmlIndex].toString().contains('src') && xmlData[0][element[index].toString()]![xmlIndex].toString().contains('title'))
    {
      try{
        return YouTubeThumbNailWidget(
            videoId: XmlHandler.idExtractor(XmlHandler.srcExtractor(xmlData[0][element[index].toString()]![xmlIndex].toString())),
            image:  XmlHandler.srcExtractor(xmlData[0][element[index].toString()]![xmlIndex].toString().replaceAll('embed/', 'watch?v=').replaceAll('?feature=oembed', '&format=json')));
      } catch(e){
        try{
          return VimeoVideoContainer(
            id: XmlHandler.idVimeoExtractor(XmlHandler.srcExtractor(xmlData[0][element[index].toString()]![xmlIndex].toString())),
            title: XmlHandler.titleExtractor(xmlData[0][element[index].toString()]![xmlIndex].toString()),
          );
        }catch(e){
          return Text("");
        }
      }
    }
    //to avoid display of <a> content....</a>
    else if(element[index].toString() =='a') {
      return Text('');
    }
    // returns text with urlLink
     else if(XmlHandler.containChecker(urlGetter[0], xmlData[0][element[index].toString()]![xmlIndex].toString(),textBuilder: true) == true)
     {
       return RichTextWidget(
         urlLinks: XmlHandler.containChecker(urlGetter[0],xmlData[0][element[index].toString()]![xmlIndex].toString(),textBuilder: false),
         xmlString: xmlData[0][element[index].toString()]![xmlIndex].toString(),
          );
     }
    // return the blockquote
     else if(element[index].toString() == 'blockquote') {
       return BlockQuoteWidget(text: xmlData[0][element[index].toString()]![xmlIndex].toString().replaceAll(r'\\n', ''));
    }
     //to prevent blockquote repetition
     else if(index != 0 && element[index].toString() == 'p' && element[index-1].toString() == 'blockquote') {
      return Text('');
    }
     //return plain text
    else  return TextWidget(
        //test if content is within $A element
          textDisplay: xmlData[0][element[index].toString()]![xmlIndex].toString().replaceAll('\\n', ''),
          xmlTag: element[index].toString()
      );
  }
}
