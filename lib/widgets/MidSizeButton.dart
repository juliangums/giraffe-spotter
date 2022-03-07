import 'package:flutter/material.dart';
import 'package:giraffe_spotter/config/Palette.dart';
import 'package:giraffe_spotter/config/Styles.dart';

class MidSizeButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final double heightSize;
  final double widthSize;

  const MidSizeButton({Key? key, required this.onTap, required this.text, required this.heightSize, required this.widthSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(
        height: heightSize,
        width: widthSize,
      ),
      child: ElevatedButton(
        key: Key('midButton'),
        style: ElevatedButton.styleFrom(
          elevation: 4,
          primary: Palette.accentColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        //jump on page at a time
        onPressed: onTap,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text, style: Styles.onBoardNext),
            ),
          ],
        ),
      ),
    );
  }
}
