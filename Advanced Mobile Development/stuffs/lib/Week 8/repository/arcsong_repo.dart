import 'package:stuffs/Week%208/models/arcsong.dart';
import 'package:stuffs/Week%208/schemas/arcsong_creation_schema.dart';

abstract class ArcsongRepository {
  Future<Arcsong> newArcsong(ArcsongCreationSchema newArcsong);

  Future<List<Arcsong>> getArcsongs();
}
