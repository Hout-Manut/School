import 'package:stuffs/Week%208/models/difficulty.dart';

enum Side {
  light(0),
  conflict(1),
  colorless(2),
  lephon(3);

  final int value;

  const Side(this.value);
}

class Arcsong {
  final String firebaseId;
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

  Arcsong({
    required this.firebaseId,
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
}
