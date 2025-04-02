import 'package:stuffs/Week%208/models/difficulty.dart';
import 'package:stuffs/Week%208/models/enums.dart';

class DifficultyDto {
  static Map<String, dynamic> toJson(Difficulty diff) {
    return {
      "rating": diff.rating,
      if (diff.version == null) "version": diff.version,
      if (diff.ratingPlus == null) "ratingPlus": diff.ratingPlus,
      "ratingClass": diff.ratingClass.value,
      "chartDesigner": diff.chartDesigner,
      "jacketDesigner": diff.jacketDesigner,
    };
  }

  static Difficulty fromJson(Map<String, dynamic> json) {
    return Difficulty(
      rating: json['rating'],
      ratingClass: json['ratingClass'],
      chartDesigner: json['chartDesigner'] ?? '',
      jacketDesigner: json['jacketDesigner'] ?? '',
      ratingPlus: json['ratingPlus'],
      version: json['version'],
    );
  }

  static RatingClass ratingClassFromInt(int ratingClassValue) {
    for (RatingClass rtClass in RatingClass.values)
      if (rtClass.value == ratingClassValue) return rtClass;
    throw Exception('Unknown rating class value $ratingClassValue');
  }
}
