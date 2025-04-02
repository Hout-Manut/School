import 'package:stuffs/Week%208/models/difficulty.dart';

class DifficultyDto {
  static Map<String, dynamic> toJson(Difficulty diff) {
    return {
      "rating": diff.rating,
      if (diff.version == null) "version": diff.version!,
      if (diff.ratingPlus) "ratingPlus": diff.ratingPlus,
      "ratingClass": diff.ratingClass.value,
      "chartDesigner": diff.chartDesigner,
      "jacketDesigner": diff.jacketDesigner,
    };
  }
}