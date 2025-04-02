import 'package:flutter/widgets.dart';
import 'package:stuffs/Week%208/models/arcsong.dart';
import 'package:stuffs/Week%208/repository/arcsong_repo.dart';
import 'package:stuffs/Week%208/schemas/arcsong_creation_schema.dart';
import 'package:stuffs/Week%208/utils/async_value.dart';

class ArcsongProvider with ChangeNotifier {
  final ArcsongRepository _repository;
  AsyncValue<List<Arcsong>> arcsongsState = AsyncValue.initial();

  ArcsongProvider(this._repository) {
    fetchArcsongs();
  }

  void fetchArcsongs() async {
    try {
      arcsongsState = AsyncValue.loading();
      notifyListeners();

      arcsongsState = AsyncValue.success(await _repository.getArcsongs());
    } catch (e) {
      arcsongsState = AsyncValue.error(e);
    }
    notifyListeners();
  }

  void addArcsong(ArcsongCreationSchema arcsongSchema) {
    _repository.newArcsong(arcsongSchema);

    fetchArcsongs();
  }
}
