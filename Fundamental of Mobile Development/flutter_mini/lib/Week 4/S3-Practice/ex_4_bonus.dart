import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: const Text("Scores"),
      ),
      backgroundColor: Colors.lightGreen,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SizedBox(
            width: 700,
            child: Column(
              children: [
                ProgressCard(
                  "My score in Flutter",
                  gradient: [
                    Colors.green[200]!,
                    Colors.green[900]!,
                  ],
                ),
                const SizedBox(height: 10),
                ProgressCard(
                  "My score in Dart",
                  gradient: [
                    Colors.green[200]!,
                    Colors.green[900]!,
                  ],
                  defaultValue: 2, // starts from 2 (min: 0, max: 9)
                ),
                const SizedBox(height: 10),
                ProgressCard(
                  "My score in React",
                  gradient: [
                    Colors.green[200]!,
                    Colors.green[900]!,
                  ],
                ),
                const SizedBox(height: 10),
                const ProgressCard(
                  "Saihong O' Meter",
                  gradient: [
                    Colors.red,
                    Colors.orange,
                    Colors.yellow,
                    Colors.green,
                    Colors.blue,
                    Colors.indigo,
                    Colors.purple,
                  ],
                  maxValue: 49, // 50 steps
                  minimumPercentage: 0.01, // Bar always is 1% filled
                )
              ],
            ),
          ),
        ),
      ),
    ),
  ));
}

class ProgressCard extends StatefulWidget {
  final String title;
  final Color color;
  final List<Color>? gradient;
  final int minValue;
  final int? defaultValue;
  final int maxValue;

  /// The minimum value from 0.0 to 1.0 of the range you can set to.
  /// Setting this to above 0.0 will make the bar never empty.
  final double minimumPercentage;

  const ProgressCard(
    this.title, {
    this.color = Colors.blue,
    this.gradient,
    this.minValue = 0,
    this.defaultValue,
    this.maxValue = 9,
    this.minimumPercentage = 0,
    super.key,
  });

  @override
  State<ProgressCard> createState() => _ProgressState();
}

class _ProgressState extends State<ProgressCard> {
  late int currentValue;
  late double extrusionAmount;
  final int extrudeTime = 90;
  double minimumPercentage = 0.01;
  static const double basePadding = 20;
  static const double borderRadius = 16;

  double leftPadding = basePadding;
  double rightPadding = basePadding;

  void calculateExtrusionAmount() {
    if (steps <= 20) {
      extrusionAmount = 10.0;
    } else if (steps >= 80) {
      extrusionAmount = 5.0;
    } else {
      extrusionAmount = 2.0;
    }

    // if (extrusionAmount > 10) {
    //   extrudeTime = 80;
    // } else {
    //   extrudeTime = 90;
    // }
  }

  @override
  void initState() {
    currentValue = widget.defaultValue ?? widget.minValue;
    minimumPercentage = widget.minimumPercentage;
    calculateExtrusionAmount();
    super.initState();
  }

  void resetPadding() {
    setState(() {
      minimumPercentage = widget.minimumPercentage;
      leftPadding = basePadding;
      rightPadding = basePadding;
    });
  }

  int get steps => widget.maxValue - widget.minValue;

  /// The normalized value from 0.0 to 1.0.
  double get currentFactor {
    double factor = currentValue / widget.maxValue;
    if (factor <= minimumPercentage) return minimumPercentage;
    return factor;
  }

  Color get color {
    List<Color>? colors = widget.gradient;
    Color? finalColor;
    if (colors == null) {
      return widget.color;
    } else if (colors.length == 1) {
      return colors[0];
    } else if (currentFactor == 1.0) {
      return colors.last;
    }

    double stepSize = 1.0 / (colors.length - 1);

    for (int i = 1; i < colors.length; i++) {
      double startFactor = (i - 1) * stepSize;
      double endFactor = i * stepSize;

      if (currentFactor >= startFactor && currentFactor <= endFactor) {
        double localFactor =
            (currentFactor - startFactor) / (endFactor - startFactor);
        finalColor = Color.lerp(colors[i - 1], colors[i], localFactor);
        break;
      }
    }

    return finalColor ?? colors.last;
  }

  void increase() {
    setState(() {
      if (currentValue == widget.maxValue) {
        rightPadding = basePadding - extrusionAmount;
        leftPadding = basePadding + extrusionAmount / 2;
        minimumPercentage = 0;
        return;
      }
      currentValue += 1;
    });
  }

  void decrease() {
    setState(() {
      if (currentValue == widget.minValue) {
        leftPadding = basePadding - extrusionAmount;
        rightPadding = basePadding + extrusionAmount / 2;
        minimumPercentage = 0;
        return;
      }
      currentValue -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.grey,
            ),
          ),
          Center(
            child: SizedBox(
              width: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: decrease,
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.grey,
                    ),
                    tooltip: "Decrease",
                  ),
                  IconButton(
                    onPressed: increase,
                    icon: const Icon(
                      Icons.add,
                      color: Colors.grey,
                    ),
                    tooltip: "Increase",
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          AnimatedPadding(
            duration: Duration(milliseconds: extrudeTime),
            curve: Curves.easeOut,
            padding: EdgeInsets.only(
              left: leftPadding,
              right: rightPadding,
            ),
            onEnd: resetPadding,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              clipBehavior: Clip.antiAlias,
              height: 48,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(borderRadius),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return AnimatedContainer(
                          width: constraints.maxWidth * currentFactor,
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOutExpo,
                          decoration: BoxDecoration(
                            color: color,
                            borderRadius: BorderRadius.circular(16),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
