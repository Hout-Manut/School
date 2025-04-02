import 'package:stuffs/Week%208/dto/difficulty_dto.dart';
import 'package:stuffs/Week%208/models/arcsong.dart';

class ArcsongDto {
  static Map<String, dynamic> toJson(Arcsong song) {
    return {
      "firebaseId": song.firebaseId,
      "idx": song.idx,
      "id": song.id,
      "artist": song.artist,
      "audioPreview": song.audioPreview,
      "audioPreviewEnd": song.audioPreviewEnd,
      "bg": song.bg,
      "bgInverse": song.bgInverse,
      "bpm": song.bpm,
      "bpmBase": song.bpmBase,
      "date": song.date.millisecond,
      "set": song.packId,
      "side": song.side.value,
      "version": song.version,
      "difficulties": List.generate(
        song.difficulties.length,
        (index) => DifficultyDto.toJson(
          song.difficulties[index],
        ),
      ),
    };
  }
}
