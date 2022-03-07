import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:giraffe_spotter/blocs/filterGiraffes/FilterState.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/pages/favourite/widgets/FilterInfo.dart';

class Filter extends StatelessWidget{
  FilterState? fState;

  Filter({this.fState});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top:10.0),
            child: Image.asset(Assets.line),
          ),
          FilterInfo(fState: fState)
        ],
      ),
    );
  }

}