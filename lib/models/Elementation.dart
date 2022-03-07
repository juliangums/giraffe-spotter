import 'package:equatable/equatable.dart';
import 'package:xml/xml.dart';

class Elementation extends Equatable{
  final String xmlParent;
  final XmlElement xmlElement;

  Elementation(this.xmlParent, this.xmlElement);


  @override
  List<Object?> get props => [xmlParent,xmlElement];

}