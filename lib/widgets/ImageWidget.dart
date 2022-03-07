import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/widgets/LoadingWidget.dart';

// ignore: must_be_immutable
class ImageWidget extends StatelessWidget {
  final String? image;
  final bool page;
  final String? asset;

  ImageWidget({this.asset = Assets.map, required this.page, this.image});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return image != null && image!.isNotEmpty
        ? CachedNetworkImage(
            fit: page ? BoxFit.fitWidth : BoxFit.cover,
            width: width,
            imageUrl: image!,
            placeholder: (context, image) => LoadingPlaceHolder(),
            errorWidget: (context, image, error) => Image.asset(Assets.map),
          )
        : Image.asset(Assets.map);
  }
}
