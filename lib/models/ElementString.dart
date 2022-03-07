import 'package:equatable/equatable.dart';

class ElementString extends Equatable{

  final String xmlString;

  ElementString(this.xmlString);

  @override
  List<Object?> get props => [xmlString];
}