class String {
  final String value;

  const String(this.value);

  String subString(int index, [int? endIndex]) {
    int startIndex;
    if (endIndex == null) {
      endIndex = index;
      startIndex = 0;
    } else {
      startIndex = index;
    }

    return this.value
  }
}

void main() {
  const point1 = FrozenPoint(1, 3);

  print("${point1.x} ${point1.y}");

  const point2 = point1.translate
}