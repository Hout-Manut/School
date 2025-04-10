import 'package:stuffs/Week%208/models/difficulty.dart';
import 'package:stuffs/Week%208/models/enums.dart';

class Title {
  final String en;
  final String? ja;

  Title(this.en, this.ja);
}

class Arcsong {
  final String firebaseKey;
  final int idx;
  final String id;
  final Title title;
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

  Arcsong({
    required this.firebaseKey,
    required this.idx,
    required this.id,
    required this.title,
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

  @override
  bool operator ==(Object other) {
    return other is Arcsong && idx == other.idx && id == other.id;
  }

  @override
  int get hashCode => idx.hashCode ^ id.hashCode;
}
