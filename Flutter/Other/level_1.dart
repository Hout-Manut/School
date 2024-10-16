class Point{
  double x, y;

  Point(this.x, this.y);

  void translate(double dx, double dy) {
    this.x += dx;
    this.y += dy;
  }
}


void main() {
  Point point1 = Point(1, 1);
  Point point2 = Point(1, 1);
  Point point3 = Point(1, 1);

  print("Point 1 Before: ${point1.x}, ${point1.y}");
  point1.translate(2, 1);
  print("Point 1 After: ${point1.x}, ${point1.y}");

  print("");

  print("Point 2 Before: ${point2.x}, ${point2.y}");
  point2.translate(2, -20);
  print("Point 2 After: ${point2.x}, ${point2.y}");

  print("");

  print("Point 3 Before: ${point3.x}, ${point3.y}");
  point3.translate(0, 3);
  print("Point 3 After: ${point3.x}, ${point3.y}");

}