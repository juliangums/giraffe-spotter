import 'package:equatable/equatable.dart';

class FavouriteState extends Equatable  {

  FavouriteState({this.giraffeFav, required this.giraffeDet});

  final List<int>? giraffeFav;
   List<int> giraffeDet = [2323];

  FavouriteState copyWith({List<int>? giraffeFav, List<int>? giraffeDet}) => FavouriteState(giraffeFav: giraffeFav, giraffeDet: giraffeDet ?? this.giraffeDet);

  @override
  List<Object?> get props => [giraffeFav,giraffeDet];
}