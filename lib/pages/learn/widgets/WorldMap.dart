import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/Assets.dart';
import 'package:giraffe_spotter/pages/learn/widgets/MapSearch.dart';

class WorldMap extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 29),
            child: MapSearchBar(
              hintText: "Search for a city, country, region ",
            ),
          ),
        ),
        height: 470,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage(Assets.worldMap), fit: BoxFit.fill),
        ));
  }
}
