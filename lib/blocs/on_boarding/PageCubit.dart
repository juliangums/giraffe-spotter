import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageCubit extends Cubit<int> {
  PageController pageController = PageController();
  final initialPage;
  final keepPage;
  final viewportFraction;
  PageCubit({this.initialPage = 0, this.keepPage = true, this.viewportFraction = 1.0}): super(initialPage) {
    pageController = PageController(initialPage: initialPage, keepPage: keepPage, viewportFraction: viewportFraction);
  }

  void updatePageState(int index) {
    if (state == index) return;

    pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.easeInOutSine);
    emit(index);
  }

  void jumpToLast() {
    {pageController.animateToPage(2, duration: Duration(milliseconds: 1), curve: Curves.easeInOutSine);}
    emit(2);
  }
}
