import 'package:equatable/equatable.dart';

class Species extends Equatable {

  final String name;
  final String value;

  Species({required this.name,required this.value});

  @override
  List<Object?> get props => [name, value];
}