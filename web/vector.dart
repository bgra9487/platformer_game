import 'dart:math';

class Vector2 {
  final double x;
  final double y;

  Vector2(this.x, this.y);

  Vector2.polar(double theta, double r)
      : x = r * cos(theta),
        y = r * sin(theta);
}
