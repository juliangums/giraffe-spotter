import 'package:flutter_bloc/flutter_bloc.dart';

class PasswordCubit extends Cubit<bool> {

  PasswordCubit(bool initialState) : super(initialState);

  void toggleVisibility()=> emit(!state);
}