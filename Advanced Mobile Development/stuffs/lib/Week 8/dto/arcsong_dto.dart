import 'package:stuffs/Week%208/dto/difficulty_dto.dart';
import 'package:stuffs/Week%208/models/arcsong.dart';
import 'package:stuffs/Week%208/models/enums.dart';

class ArcsongDto {
  static Map<String, dynamic> toJson(Arcsong song) {
    return {
      'firebaseKey': song.firebaseKey,
      'idx': song.idx,
      'id': song.id,
      'artist': song.artist,
      'audioPreview': song.audioPreview,
      'audioPreviewEnd': song.audioPreviewEnd,
      'bg': song.bg,
      'bgInverse': song.bgInverse,
      'bpm': song.bpm,
      'bpmBase': song.bpmBase,
      'date': song.date.millisecond,
      'set': song.packId,
      'side': song.side.value,
      'version': song.version,
      'difficulties': List.generate(
        song.difficulties.length,
        (index) => DifficultyDto.toJson(
          song.difficulties[index],
        ),
      ),
    };
  }

  static Arcsong fromJson(String key, Map<String, dynamic> json) {
    return Arcsong(
      firebaseKey: key,
      idx: json['idx'],
      id: json['id'],
      title: titleFromJson(json['title_localized']),
      artist: json['artist'],
      audioPreview: json['audioPreview'],
      audioPreviewEnd: json['audioPreviewEnd'],
      bg: json['bg'],
      bgInverse: json['bgInverse'],
      bpm: json['bpm'],
      bpmBase: json['bpmBase'],
      date: json['date'],
      packId: json['set'],
      side: json['side'],
      version: json['version'],
      difficulties: json['difficulties'],
    );
  }

  static Title titleFromJson(Map<String, dynamic> json) {
    return Title(json['en'], json['ja'] ?? null);
  }

  static Map<String, dynamic> titleToJson(Title title) {
    return {'en': title.en, if (title.ja != null) 'ja': title.ja!};
  }

  static Side sideFromInt(int sideValue) {
    for (Side side in Side.values) if (side.value == sideValue) return side;
    throw Exception('Unknown side value $sideValue');
  }
}
