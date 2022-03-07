import 'package:giraffe_spotter/utils/spline.dart';

class Bbox {
  bbox(Point coords1, Point coords2) {
    double x1 = coords1.x!;
    double y1 = coords1.y!;
    double x2 = coords2.x!;
    double y2 = coords2.y!;
    double west = x1 < x2 ? x1 : x2;
    double south = y1 < y2 ? y1 : y2;
    double east = x1 > x2 ? x1 : x2;
    double north = y1 > y2 ? y1 : y2;

    return [west, south, east, north];
  }
}
