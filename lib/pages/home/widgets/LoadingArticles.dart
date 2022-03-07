import 'package:flutter/material.dart';
import 'package:giraffe_spotter/widgets/LoadingWidget.dart';

class LoadingPage extends StatelessWidget{

  final bool search;

  LoadingPage({this.search = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          search == false ? LoadingSearchBar()
               : Container(),
          GridViewLoadingWidget()
        ],
      ),
    );
  }
}

