import 'package:flutter_bloc/flutter_bloc.dart';

class ShareButtonCubit extends Cubit<bool> {
  ShareButtonCubit() : super(false);

  void getLink(bool disabled) {
    emit(disabled);
  }
}
