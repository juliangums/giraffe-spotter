import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:giraffe_spotter/blocs/capture/imageCapture/ImageCaptureCubit.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/utils/GalleryUtils.dart';

class ImageContainerWidget extends StatelessWidget {
  final int index;
  final bool nothing;

  ImageContainerWidget({required this.index, this.nothing = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () => (nothing == false) ? {} : GalleryUtils().trialCode(context),
              child: Container(
                decoration: nothing == false
                    ? BoxDecoration(
                        borderRadius: new BorderRadius.only(
                          topRight: const Radius.circular(10.0),
                          topLeft: const Radius.circular(10.0),
                          bottomLeft: const Radius.circular(10.0),
                          bottomRight: const Radius.circular(10.0),
                        ),
                        image: DecorationImage(image: FileImage(context.read<ImageCaptureCubit>().imageRetrieve(index)), fit: BoxFit.cover),
                      )
                    : BoxDecoration(
                        color: Palette.borderColor,
                        borderRadius: new BorderRadius.only(
                          topRight: const Radius.circular(10.0),
                          topLeft: const Radius.circular(10.0),
                          bottomLeft: const Radius.circular(10.0),
                          bottomRight: const Radius.circular(10.0),
                        ),
                      ),
                child: nothing == false ? SizedBox() : Center(child: Icon(Icons.add_circle_rounded, size: 40, color: Palette.accentColor)),
              ),
            ),
          ),
          nothing == false
              ? Transform.translate(
                  offset: Offset(13, 18),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: GestureDetector(
                      onTap: () => context.read<ImageCaptureCubit>().removePicked(index),
                      child: PhysicalModel(
                        color: Colors.transparent,
                        elevation: 7,
                        borderRadius: BorderRadius.circular(0.2),
                        shape: BoxShape.circle,
                        shadowColor: Palette.borderColor.withOpacity(0.1),
                        child: SvgPicture.asset(Assets.remove),
                      ),
                    ),
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
