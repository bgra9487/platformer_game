import 'package:test/test.dart';
import '../web/vector.dart';
import 'dart:math';

void main() {
  test("Testing base constructor", () {
    var vector = Vector2(1, 0);
    expect(vector.x, equals(1));
    expect(vector.y, equals(0));
  });

  test("Testing polar constructor", () {
    var vector = Vector2.polar(pi/6, 5);
    expect(vector.x, equals(4));
    expect(vector.y, equals(3));
  });
}