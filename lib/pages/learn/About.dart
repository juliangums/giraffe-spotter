import 'package:flutter/material.dart';
import 'package:giraffe_spotter/pages/learn/widgets/TopAbout.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TopAbout(),
        // WorldMap(),
        // BottomAbout()
      ],
    );
  }
}
