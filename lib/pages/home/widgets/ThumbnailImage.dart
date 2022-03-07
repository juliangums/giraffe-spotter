import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Thumbnail extends StatelessWidget {
  final String? image;

  Thumbnail({this.image});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(image!),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
