import 'package:flutter/material.dart';

import 'MapDisplay.dart';


class DialogContent extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Transform.scale(
              //dialog size
              scale: 1.13,
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                  ),
                child: MapDisplay(),
              ),
            )
        ),
      ),
    );
  }


}