import 'package:flutter_bloc/flutter_bloc.dart';

class DeleteCubit extends Cubit<bool> {

  bool initialState;
  DeleteCubit({this.initialState = false}) : super(initialState);

  void updatePageState(bool delete) {
    if(delete == false)return;
    initialState =  delete;
    emit(delete);
  }
}
