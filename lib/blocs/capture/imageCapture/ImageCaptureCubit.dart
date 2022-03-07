import 'dart:io';
import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:giraffe_spotter/models/ImageFile.dart';

class ImageCaptureCubit extends Cubit<ImageFile> {
  List<File> assets = [];
  List<int>? numbers;
  File? file;
  List<File>? profileAsset;
  double? longitude;
  double? latitude;
  DateTime? dateTime;

  ImageCaptureCubit({required this.assets, this.file, this.profileAsset}) : super(ImageFile());

  //parameter has assetEntity list ...
  void imagePicker(asset) async {
    emit(state.copyWith(file: file, status: FormzStatus.submissionInProgress, files: List.of(assets.toSet())));
    if (asset != null && assets.length < 10) {
      assets.add(asset);
      emit(state.copyWith(file: file, status: FormzStatus.submissionSuccess, files: List.of(assets.toSet())));
    }
  }

  //remove the file from the List<File>
  void removePicked(int index) async {
    emit(state.copyWith(file: file, status: FormzStatus.submissionInProgress, files: assets));
    assets.removeAt(index);
    emit(state.copyWith(file: file, status: FormzStatus.submissionSuccess, files: assets));
  }

  imageRetrieve(int index) {
    //number of assets ---  index
    File? image;
    image = assets[index];
    return image;
  }

  //to select profile image
  void profileImage(File asset) async {
     file = asset;
    emit(state.copyWith(files: List.of(assets.toSet()), file: file, status: FormzStatus.submissionSuccess));
  }

  //clear the assets
  void clearAll() {
    if (assets.isNotEmpty) {
      assets = [];
      assets.clear();
      emit(state.copyWith(file: file, status: FormzStatus.submissionSuccess, files: List.of(assets.toSet())));
    }
  }

  randomNumber(min, max) {
    var rn = new Random();
    return min + rn.nextInt(max - min);
  }
}
