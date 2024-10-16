import 'level_4.dart';

class Point {
  double x, y;

  Point(this.x, this.y);

  @override
  String toString() {
    return "Point($x, $y)";
  }
}


class Shape {
  late Point origin;
  late Distance width, height;
  int? backgroundColor;

  Shape(Point origin, { required Distance width,  required Distance height, int? backgroundColor }) {
    this.origin = origin;
    this.width = width;
    this.height = height;
    this.backgroundColor = backgroundColor;
  }

  Point get topLeft => Point(origin.x, origin.y + height.m);
  Point get topRight => Point(origin.x + width.m, origin.y + height.m);
  Point get bottomLeft => origin;
  Point get bottomRight => Point(origin.x + width.m, origin.y);
}


void main() {
  Point p1 = Point(1, 2);

  Shape s1 = Shape(p1, width: Distance.m(4), height: Distance.m(8));

  print("Top Light: ${s1.topLeft}");
  print("Top Right: ${s1.topRight}");
  print("Bottom Left: ${s1.bottomLeft}");
  print("Bottom Right: ${s1.bottomRight}");
}
