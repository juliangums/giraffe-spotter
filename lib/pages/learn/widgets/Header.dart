import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/Styles.dart';

// ignore: must_be_immutable
class Header extends StatelessWidget {
  String title;
  Header({required this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: Styles.appBarTitle,
          ),
        ],
      ),
    );
  }
}
