import 'dart:math';

import 'package:equatable/equatable.dart';

class Point extends Equatable {
  final double? x;
  final double? y;
  final double? z; //unknown ??

  Point({this.x, this.z, this.y});

  Point copyWith({double? x, double? y, double? z}) => Point(x: x ?? this.x, y: y ?? this.y, z: z ?? this.z);


  @override
  String toString() {
    return 'x: $x, y: $y, z: $z';
  }

  @override
  List<Object?> get props => [x, y, z];
}

class Options extends Equatable {
  final int? duration;

  final List<Point>? points;
  final double? sharpness;
  final List<Point>? centers;
  final List? controls;
  final num? stepLength;
  final int? length;
  final num? delay;
  final List<int>? steps;

  Options({this.duration, this.points, this.sharpness, this.centers, this.controls, this.stepLength, this.length, this.delay, this.steps});

  @override
  List<Object?> get props => [duration, delay, points, steps, stepLength, sharpness, controls, centers];
}

class Spline {
  late int duration;
  late List<Point> points; //      [   [90,09,z], [23,80,z], [12,23,z]  ]
  late double sharpness;
  late List<Point> centers;
  late List<List<Point>> controls; //      [  [[90,09,z], [23,80,z]], [[90,09,z], [23,80,z]]  ]
  late num stepLength;
  late int length;
  late num delay;
  List? steps;

  Spline(Options options) {
    this.points = options.points ?? [];
    this.duration = options.duration ?? 10000;
    this.sharpness = options.sharpness ?? 0.85;
    this.centers = [];
    this.controls = [];
    this.stepLength = options.stepLength ?? 60;
    this.length = options.length!;
    this.delay = 0;

    // this is to ensure compatibility with the 2d version
    for (int i = 0; i < this.length; i++) {
      this.points[i] = this.points[i].copyWith(z: this.points[i].z ?? 0);
      // this.points[i].z = this.points[i].z || 0;
    }
    for (int i = 0; i < this.length - 1; i++) {
      var p1 = this.points[i];
      var p2 = this.points[i + 1];
      this.centers.add(Point(x: (p1.x! + p2.x!) / 2, y: (p1.y! + p2.y!) / 2, z: (p1.z! + p2.z!) / 2));
    }
    this.controls.add([this.points[0], this.points[0]]);
    // this.controls.push([this.points[0], this.points[0]]);
    for (int i = 0; i < this.centers.length - 1; i++) {
      var dx = this.points[i + 1].x! - (this.centers[i].x! + this.centers[i + 1].x!) / 2;
      var dy = this.points[i + 1].y! - (this.centers[i].y! + this.centers[i + 1].y!) / 2;
      var dz = this.points[i + 1].z! - (this.centers[i].z! + this.centers[i + 1].z!) / 2;
      this.controls.add([
        Point(
          x: (1.0 - this.sharpness) * this.points[i + 1].x! + this.sharpness * (this.centers[i].x! + dx),
          y: (1.0 - this.sharpness) * this.points[i + 1].y! + this.sharpness * (this.centers[i].y! + dy),
          z: (1.0 - this.sharpness) * this.points[i + 1].z! + this.sharpness * (this.centers[i].z! + dz),
        ),
        Point(
          x: (1.0 - this.sharpness) * this.points[i + 1].x! + this.sharpness * (this.centers[i + 1].x! + dx),
          y: (1.0 - this.sharpness) * this.points[i + 1].y! + this.sharpness * (this.centers[i + 1].y! + dy),
          z: (1.0 - this.sharpness) * this.points[i + 1].z! + this.sharpness * (this.centers[i + 1].z! + dz),
        )
      ]);
    }
    this.controls.add([
      this.points[this.length - 1],
      this.points[this.length - 1],
    ]);
    this.steps = this.cacheSteps(this.stepLength);
    print('Calculated steps: $steps');
  }

  /// Caches an array of equidistant (more or less) points on the curve.
  List<num> cacheSteps(num mindist) {
    List<num> steps = [];
    var laststep = pos(0);

    steps.add(0);
    for (int t = 0; t < this.duration; t += 10) {
      Point step = this.pos(t);
      var dist = sqrt((step.x! - laststep.x!) * (step.x! - laststep.x!) +
          (step.y! - laststep.y!) * (step.y! - laststep.y!) +
          (step.z! - laststep.z!) * (step.z! - laststep.z!));
      if (dist > mindist) {
        steps.add(t);
        laststep = step;
      }
    }
    return steps;
  }

  /// Gets the position of the point, given time.
  ///
  /// WARNING: The speed is not constant. The time it takes between control points is constant.
  ///
  /// For constant speed, use Spline.steps[i];
  Point pos(num time) {
    num t = time - delay;
    if (t < 0) {
      t = 0;
    }

    if (t > duration) {
      t = duration - 1;
    }

    // t = t-this.delay;
    num t2 = t / duration;

    if (t2 >= 1) {
      return points[length - 1];
    }

    int n = ((points.length - 1) * t2).floor();
    num t1 = (length - 1) * t2 - n;

    return bezier(t1, points[n], controls[n][1], controls[n + 1][0], points[n + 1]);
  }
}

bezier(num t, Point p1, Point c1, Point c2, Point p2) {
  List<num> b = B(t);

  Point pos = Point(
    x: p2.x! * b[0] + c2.x! * b[1] + c1.x! * b[2] + p1.x! * b[3],
    y: p2.y! * b[0] + c2.y! * b[1] + c1.y! * b[2] + p1.y! * b[3],
    z: p2.z! * b[0] + c2.z! * b[1] + c1.z! * b[2] + p1.z! * b[3],
  );

  return pos;
}

B(num t) {
  num t2 = t * t;
  num t3 = t2 * t;

  return [
    t3,
    3 * t2 * (1 - t),
    3 * t * (1 - t) * (1 - t),
    (1 - t) * (1 - t) * (1 - t),
  ];
}
