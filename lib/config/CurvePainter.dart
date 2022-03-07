import 'package:flutter/material.dart';


class CurvePainter extends CustomPainter {

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    // paint.color = Palette.curvePaint;
    paint.style = PaintingStyle.fill; // Change this to fill

    var path = Path();

    path.moveTo(0,size.height * 0.137);// <---start point
    path.quadraticBezierTo(
        size.width * 0.109, size.height * 0.15, // point Ax,y
        size.width * 0.186, size.height * 0.090 // point Bx,y
    );
    path.quadraticBezierTo(
        size.width * 0.209, size.height * 0.055,// point Cx,y
        size.width * 0.195,size.height * 0.030,//point Dx,y
    );
    path.quadraticBezierTo(
        size.width * 0.205,size.height * 0.040, //point Ex,y
        size.width *  0.165, size.height *0.0 // <---- end point
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}