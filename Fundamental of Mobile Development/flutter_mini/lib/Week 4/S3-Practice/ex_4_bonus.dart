import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(
        title: Text("Scores"),
      ),
      backgroundColor: Colors.lightGreen,
      body: Center(
        child: SizedBox(
          width: 700,
          child: Column(
            children: [
              ProgressCard(
                "Saihong O' Meter",
                gradient: [
                  Colors.red,
                  Colors.orange,
                  // Colors.yellow,
                  // Colors.green,
                  // Colors.blue,
                  // Colors.indigo,
                  // Colors.purple,
                ],
                maxValue: 20,
              )
            ],
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

  const ProgressCard(
    this.title, {
    this.color = Colors.blue,
    this.gradient,
    this.minValue = 0,
    this.defaultValue,
    this.maxValue = 9,
    super.key,
  });

  @override
  State<ProgressCard> createState() => _ProgressState();
}

class _ProgressState extends State<ProgressCard> {
  late int currentValue;
  late double extrusionAmount;
  late int extrudeTime;
  static const double basePadding = 20;

  double leftPadding = basePadding;
  double rightPadding = basePadding;
  int get steps => widget.maxValue - widget.minValue;

  void calculateExtrusionAmount() {
    if (steps <= 1) {
      extrusionAmount = 15.0;
    } else if (steps >= 100) {
      extrusionAmount = 2.0;
    } else {
      extrusionAmount = 15 - (17 * ((steps - 1) / 99));
    }

    if (extrusionAmount > 10) {
      extrudeTime = 70;
    } else {
      extrudeTime = 90;
    }
  }

  @override
  void initState() {
    currentValue = widget.defaultValue ?? widget.minValue;
    calculateExtrusionAmount();
    super.initState();
  }

  void resetPadding() {
    setState(() {
      leftPadding = basePadding;
      rightPadding = basePadding;
    });
  }

  /// The normalized value from 0.0 to 1.0.
  double get currentFactor {
    return currentValue / widget.maxValue;
  }

  Color get color {
    List<Color>? colors = widget.gradient;
    Color? finalColor;
    if (colors == null) return widget.color;
    if (currentFactor == 1.0) return colors.last;

    int colorIndex = 1;

    for (int i = 1; i < steps; i++) {
      if (currentFactor < (colorIndex / (colors.length - 1))) {
        finalColor = Color.lerp(
            colors[colorIndex - 1], colors[colorIndex], currentFactor / (colors.length - 1));
        // finalColor = colors[i];
        break;
      }
      colorIndex++;
    }

    return finalColor ?? colors.last;
  }

  void increase() {
    setState(() {
      if (currentValue == widget.maxValue) {
        rightPadding = basePadding - extrusionAmount;
        leftPadding = basePadding + extrusionAmount;
        return;
      }
      currentValue += 1;
    });
  }

  void decrease() {
    setState(() {
      if (currentValue == widget.minValue) {
        leftPadding = basePadding - extrusionAmount;
        rightPadding = basePadding + extrusionAmount;
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
        borderRadius: BorderRadius.circular(16),
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
                borderRadius: BorderRadius.circular(16),
              ),
              clipBehavior: Clip.antiAlias,
              height: 48,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(16),
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
