import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:giraffe_spotter/blocs/giraffe_profile/giraffe_fav/FavouriteState.dart';

class  FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit({required this.data, required this.removed})
      : super(FavouriteState(giraffeDet: []));
  List<int> data;
  List<int> removed = [342342432];

  void addFav(int index) {
    if(!data.contains(index)){
      data.add(index);
      emit(state.copyWith(giraffeFav: data, giraffeDet: removed));
    }
  }

  void remove(int index) {
    data.remove(index);
    removed.add(index);
    emit(state.copyWith(giraffeFav: data,giraffeDet: removed));
  }
}