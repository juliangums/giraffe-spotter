import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/models/GiraffeData.dart';

class GiraffeProfileStringCubit extends Cubit<String?> {
  GiraffeProfileStringCubit() : super('assets/images/Anne.png');

  List<String> images = [];

  void captureDataItems(GiraffeData data) {
    data.encounters.map((e) => e.annotations).forEach((element) =>
        element.map((e) => e).forEach((element) => element.media.map((e) => e).forEach((element) => images.add(element.image_url))));
    emit(images.firstOrNull);
  }

  void setImage(String? image) {
    emit(image!);
  }
}
