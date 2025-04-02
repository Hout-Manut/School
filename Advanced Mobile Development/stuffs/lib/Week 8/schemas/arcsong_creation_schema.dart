import 'package:stuffs/Week%208/dto/difficulty_dto.dart';
import 'package:stuffs/Week%208/models/difficulty.dart';
import 'package:stuffs/Week%208/models/enums.dart';

class ArcsongCreationSchema {
  final int idx;
  final String id;
  final String artist;
  final int audioPreview;
  final int audioPreviewEnd;
  final String bg;
  final String bgInverse;
  final String bpm;
  final double bpmBase;
  final DateTime date;
  final String packId;
  final Side side;
  final String version;
  final List<Difficulty> difficulties;

  ArcsongCreationSchema({
    required this.idx,
    required this.id,
    required this.artist,
    required this.audioPreview,
    required this.audioPreviewEnd,
    required this.bg,
    required this.bgInverse,
    required this.bpm,
    required this.bpmBase,
    required this.date,
    required this.packId,
    required this.side,
    required this.version,
    required this.difficulties,
  });

  Map<String, dynamic> toJson() {
    return {
      'idx': idx,
      'id': id,
      'artist': artist,
      'audioPreview': audioPreview,
      'audioPreviewEnd': audioPreviewEnd,
      'bg': bg,
      'bgInverse': bgInverse,
      'bpm': bpm,
      'bpmBase': bpmBase,
      'date': date.millisecond,
      'set': packId,
      'side': side.value,
      'version': version,
      'difficulties': List.generate(
        difficulties.length,
        (index) => DifficultyDto.toJson(
          difficulties[index],
        ),
      ),
    };
  }
}
