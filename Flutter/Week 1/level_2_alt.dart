class FrozenPoint {
  final double x, y;

  FrozenPoint(this.x, this.y);

  FrozenPoint translate(double dx, double dy) {
    return FrozenPoint(x + dx, y + dy);
  }

  @override
  String toString() {
    return "FrozenPoint($x, $y)";
  }
}

void main() {
  FrozenPoint point1 = FrozenPoint(1, 3);
  print(point1);

  FrozenPoint point1After = point1.translate(2, 4);
  print(point1After);
}
