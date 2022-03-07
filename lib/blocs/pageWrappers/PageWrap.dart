import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class PageWrapCubit extends Cubit<int> {
  ScrollController controller = ScrollController();
  PageWrapCubit() : super(0){
    controller =  ScrollController(initialScrollOffset: 0.0,keepScrollOffset: false);
  }

  void  restoreScroll(){
    controller.jumpTo(0.0);
  }

}
