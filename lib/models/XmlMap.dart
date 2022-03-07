import 'package:equatable/equatable.dart';

class XmlMap extends Equatable{

  final String elementNode;
  final List<String> elementValue;

  XmlMap(this.elementNode, this.elementValue);

  @override
  List<Object?> get props => [elementNode,elementValue];


}