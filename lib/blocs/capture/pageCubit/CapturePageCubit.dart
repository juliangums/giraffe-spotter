import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CapturePageCubit extends Cubit<int> {
  PageController pageController = PageController();
  String title;
  final initialPage;
  final keepPage;
  final viewportFraction;

  CapturePageCubit({this.title = 'Upload photos', this.initialPage = 0, this.keepPage = true, this.viewportFraction = 1.0}) : super(initialPage) {
    pageController = PageController(initialPage: initialPage, keepPage: keepPage, viewportFraction: viewportFraction);
  }

  void updatePageState(int index) {
    if (state == index) return;
    pageController.animateToPage(index, duration: Duration(milliseconds: 1), curve: Curves.easeInOutSine);
    updateTitle(index);
    emit(index);
  }

  void updateTitle(int index) {
    index == 0 ? title = 'Upload photos': title = 'Upload Details' ;
  }
}
