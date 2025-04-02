enum RatingClass {
  past(0),
  present(1),
  future(2),
  beyond(3),
  eternal(4);

  final int value;

  const RatingClass(this.value);
}

class Difficulty {
  final int rating;
  final RatingClass ratingClass;
  final bool ratingPlus;
  final String chartDesigner;
  final String jacketDesigner;
  final String? version;

  Difficulty({
    required this.rating,
    required this.ratingClass,
    this.ratingPlus = false,
    required this.chartDesigner,
    required this.jacketDesigner,
    this.version,
  });
}
