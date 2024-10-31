// I tried to add graphs, gave up.

import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';

class DataController {
  final List<Map<String, dynamic>> data;

  Iterable<String> get keys => data[0]["values"].keys ?? [];

  DataController(this.data);

  List<Map<String, dynamic>> sublistFromDay(int day) {
    if (day < 1 || day > 6) {
      throw ArgumentError('Day must be between 1 and 6.');
    }
    int startIndex = (day - 1) * 24;
    int endIndex = day * 24;

    return data.sublist(startIndex, endIndex);
  }


}


class LineGraph extends StatefulWidget {
  final List<Color> lineColors = [];
  final DataController data;

  LineGraph(this.data,{super.key});

  @override
  State<LineGraph> createState() => _LineGraphState();
}


class _LineGraphState extends State<LineGraph> {

  // Widget _plot(Map)

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

}
