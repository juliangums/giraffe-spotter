import 'dart:io';

import 'package:exif/exif.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:giraffe_spotter/blocs/capture/CaptureCubit.dart';
import 'package:giraffe_spotter/blocs/capture/date_time/DateTimeCubit.dart';
import 'package:giraffe_spotter/blocs/capture/imageCapture/ImageCaptureCubit.dart';
import 'package:giraffe_spotter/blocs/capture/map/location/LocationCubit.dart';
import 'package:image_picker/image_picker.dart';

class GalleryUtils {
  void pickImage(BuildContext context) async {
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        context.read<ImageCaptureCubit>().profileImage(File(image.path));
      }
    } catch (e) {
      throw e;
    }
  }

  void trialCode(BuildContext context) async {
    const platform = MethodChannel('ax.synt.giraffe_spotter/coordinates');
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      context.read<ImageCaptureCubit>().imagePicker(File(image.path));
      List<dynamic>? results = (await platform.invokeMethod('getCoordsFilePath', {'path': image.path}));

      if (results != null) {
        try {
          double? latitude;
          double? longitude;
          if (Platform.isIOS) {
            if ((results[0][1]).toString().toUpperCase() == 'S' || (results[0][1]).toString().toUpperCase() == 'W') {
              latitude = -results[0][0];
            } else {
              latitude = results[0][0];
            }
            if ((results[1][1]).toString().toUpperCase() == 'S' || (results[1][1]).toString().toUpperCase() == 'W') {
              longitude = -results[1][0];
            } else {
              longitude = results[1][0];
            }
          } else {
            latitude = results[0];
            longitude = results[1];
          }
          List<Placemark> placeMarks = await placemarkFromCoordinates(latitude!, longitude!);
          context.read<LocationCubit>().imageLocator(placeMarks[0], latitude, longitude);
        } catch (e) {
          throw e;
        }
      }

      final fileBytes = File(image.path).readAsBytesSync();
      Map<String?, IfdTag>? data = await readExifFromBytes(fileBytes);
      data.map((key, value) {
        if (key!.contains('DateTime') &&
            context.read<DateAndTimeCubit>().timeOfDays == null &&
            context.read<DateAndTimeCubit>().copyWithTime == null) {
          context.read<DateAndTimeCubit>().setDateTime(DateTime.parse(value.toString().replaceFirst(":", '-').replaceFirst(":", "-")));
          context
              .read<DateAndTimeCubit>()
              .setTimeOfDay(TimeOfDay.fromDateTime(DateTime.parse(value.toString().replaceFirst(":", '-').replaceFirst(":", "-"))));
          context
              .read<CaptureCubit>()
              .dateTimeChanged(context.read<DateAndTimeCubit>().copyWithTime!, context.read<DateAndTimeCubit>().timeOfDays!);
        }
        return MapEntry(key, value);
      });
    }
  }
}
