import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/AppRoute.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/ServiceLocator.dart';
import 'package:giraffe_spotter/widgets/ArrowBackButton.dart';

import 'LoadingWidget.dart';

class ZoomImage extends StatelessWidget{

  final image;

  ZoomImage({required this.image});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.dividerColor,
      appBar: AppBar(leading: ArrowBackButton(colors: Palette.primaryColor), backgroundColor: Palette.dividerColor,),
      body:GestureDetector(
        onTap: ()=> locator!<AppRoute>().back(),
        child: Container(
            color: Palette.dividerColor,
          child: Center(
            child: InteractiveViewer(
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                imageUrl: image,
                placeholder: (context, image)=> LoadingPlaceHolder(),
                errorWidget: (context, image, error) => Image.asset(Assets.map),
              )
            ),
          ),
        ),
      )
    );
  }



}