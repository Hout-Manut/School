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
  late int width, height;
  int? backgroundColor;

  Shape(Point origin, { required int width,  required int height, int? backgroundColor }) {
    this.origin = origin;
    this.width = width;
    this.height = height;
    this.backgroundColor = backgroundColor;
  }

  Point get topLeft => Point(origin.x, origin.y + height);
  Point get topRight => Point(origin.x + width, origin.y + height);
  Point get bottomLeft => origin;
  Point get bottomRight => Point(origin.x + width, origin.y);
}


void main() {
  Point p1 = Point(1, 2);

  Shape s1 = Shape(p1, width: 4, height: 8);

  print("Top Light: ${s1.topLeft}");
  print("Top Right: ${s1.topRight}");
  print("Bottom Left: ${s1.bottomLeft}");
  print("Bottom Right: ${s1.bottomRight}");
}
