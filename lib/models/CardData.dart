import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/pages/home/widgets/CardSlide.dart';

class CardData {
  final List favourites = [
    CardSlide(image: Assets.giraffePic1,imageType: false, cardTitle: "John Doe", locationName: "Kenya", onTap: () {  },),
    CardSlide(image: Assets.giraffePic2,imageType: false, cardTitle: "Anne Mary", locationName: "Mozambique", onTap: () {  },),
    CardSlide(image: Assets.giraffePic3,imageType: false, cardTitle: "Hose Maria", locationName: "Tanzania", onTap: () {  },),
    CardSlide(image: Assets.giraffePic4,imageType: false, cardTitle: "Maureen Jane", locationName: "Zambia", onTap: () {  },),
    CardSlide(image: Assets.giraffePic2,imageType: false, cardTitle: "John Doe", locationName: "Kenya", onTap: () {  },),
    CardSlide(image: Assets.giraffePic1,imageType: false, cardTitle: "Anne Mary", locationName: "Mozambique", onTap: () {  },),
  ];
}