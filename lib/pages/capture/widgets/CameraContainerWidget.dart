import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/utils/GalleryUtils.dart';

class CameraContainerWidget extends StatelessWidget {
  final bool camera;

  CameraContainerWidget({required this.camera});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => camera ? GalleryUtils().openGallery(context, true) : {},
      child: Container(
        decoration: new BoxDecoration(
            color: Palette.containerShade,
            borderRadius: new BorderRadius.only(
              topRight: const Radius.circular(10.0),
              topLeft: const Radius.circular(10.0),
              bottomLeft: const Radius.circular(10.0),
              bottomRight: const Radius.circular(10.0),
            )
        ),
        child: camera
            ? Center(child: Icon(Icons.add_a_photo_outlined, size: 40))
            : Center(),
      ),
    );
  }
}
