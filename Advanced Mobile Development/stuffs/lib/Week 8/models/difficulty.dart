import 'package:stuffs/Week%208/models/enums.dart';

class Difficulty {
  final int rating;
  final RatingClass ratingClass;
  final bool? ratingPlus;
  final String chartDesigner;
  final String jacketDesigner;
  final String? version;

  Difficulty({
    required this.rating,
    required this.ratingClass,
    required this.ratingPlus,
    required this.chartDesigner,
    required this.jacketDesigner,
    required this.version,
  });
}
