import 'package:test/test.dart';
import '../web/vector.dart';

void main() {
  test("Testing base constructor", () {
    var vector = Vector2(1, 0);
    expect(vector.x, equals(1));
    expect(vector.y, equals(0));
  });
}
