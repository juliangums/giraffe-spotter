import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/Styles.dart';

// ignore: must_be_immutable
class Region extends StatelessWidget {
  String? title;
  Region({this.title});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title!,
            style: Styles.regions,
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class Park extends StatelessWidget {
  String? country, flag, park;
  Park({this.park, this.country, this.flag});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Text(
              park!,
              style: Styles.park,
            )
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: [
            Container(
              child: Text(
                country!,
                style: Styles.country,
              ),
            ),
            Container(child: Image.asset(flag!))
          ],
        )
      ]),
    );
  }
}
