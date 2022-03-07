import 'package:equatable/equatable.dart';
import 'dart:io';

import 'package:formz/formz.dart';

//to handle the images :::: that is profile and capture page images
class ImageFile extends Equatable {
  final File? file;
  final List<File>? files;
  final List<int>? index;
  final FormzStatus status;

  ImageFile({this.file,this.index, this.status = FormzStatus.pure, this.files });

  @override
  List<Object?> get props => [file, files,index, status];

  @override
  ImageFile copyWith({File? file, List<File>? files,FormzStatus? status,List<int>? index}) =>
      ImageFile( file: file, files: files,index: index, status: status ?? this.status);
}
