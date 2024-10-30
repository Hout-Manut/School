import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_mini/Week%204/S1-Practice/weather_app/weather_widgets/cities.dart';
import 'package:flutter_mini/Week%204/S1-Practice/weather_app/weather_service.dart';

enum SelectedDay {
  yesterday(0, "Yesterday"),
  today(1, "Today"),
  tomorrow(2, "Tomorrow"),
  thirdDay(3, "Tomorrow2"),
  fourthDay(4, "Tomorrow3"),
  fifthDay(5, "Tomorrow4"),
  sixthDay(6, "Tomorrow5");

  const SelectedDay(this.i, this.tempString);

  final int i;
  final String tempString;

  SelectedDay next() {
    switch (this) {
      case SelectedDay.yesterday:
        return SelectedDay.today;
      case SelectedDay.today:
        return SelectedDay.tomorrow;
      case SelectedDay.tomorrow:
        return SelectedDay.thirdDay;
      case SelectedDay.thirdDay:
        return SelectedDay.fourthDay;
      case SelectedDay.fourthDay:
        return SelectedDay.fifthDay;
      case SelectedDay.fifthDay:
        return SelectedDay.sixthDay;
      case SelectedDay.sixthDay:
        return SelectedDay.sixthDay;
    }
  }

  SelectedDay previous() {
    switch (this) {
      case SelectedDay.yesterday:
        return SelectedDay.yesterday;
      case SelectedDay.today:
        return SelectedDay.yesterday;
      case SelectedDay.tomorrow:
        return SelectedDay.today;
      case SelectedDay.thirdDay:
        return SelectedDay.tomorrow;
      case SelectedDay.fourthDay:
        return SelectedDay.thirdDay;
      case SelectedDay.fifthDay:
        return SelectedDay.fourthDay;
      case SelectedDay.sixthDay:
        return SelectedDay.fifthDay;
    }
  }
}

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    color: Colors.white,
    home: SafeArea(child: WeatherScreen()),
  ));
}

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();

  List<Map<String, dynamic>> weatherData = [];
  bool isLoading = true;
  SelectedDay currentDay = SelectedDay.today;
  bool overlay = false;
  // String get dayStirng => _weatherService.getDayString(currentDay);
  String get dayString => currentDay.tempString;

  Future<void> _clearAndFetchData(Cities city) async {
    setState(() {
      weatherData = [];
      isLoading = true;
    });
    await _fetchData(city);
  }

  int getDayIndex() => currentDay.i;
  void setDayNext() {
    setState(() {
      currentDay = currentDay.next();
    });
  }

  void setDayPrevious() {
    setState(() {
      currentDay = currentDay.previous();
    });
  }

  void setOverlay(bool overlay) {
    setState(() {
      this.overlay = overlay;
    });
  }

  Future<void> _fetchData(Cities city) async {
    final data = await _weatherService.fetchWeatherData(city);
    setState(() {
      weatherData = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(top: 120, bottom: 40),
                child: Container(
                  height: 700,
                  decoration: BoxDecoration(color: Colors.grey),
                ),
              ),
            ),
            Stack(
              children: [
                AnimatedOpacity(
                  opacity: overlay ? 0.5 : 0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutExpo,
                  child: IgnorePointer(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.white,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Center(
                        child: Text(
                          dayString,
                          style: TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Tabs(
                        indexGetter: getDayIndex,
                        overlaySetter: setOverlay,
                        setIndexPrevious: setDayPrevious,
                        setIndexNext: setDayNext,
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Tabs extends StatefulWidget {
  final int Function() indexGetter;
  final void Function() setIndexPrevious;
  final void Function() setIndexNext;
  final void Function(bool) overlaySetter;

  const Tabs({
    required this.indexGetter,
    required this.overlaySetter,
    required this.setIndexPrevious,
    required this.setIndexNext,
    super.key,
  });

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  static const double containerWidth = 224;
  static const int daysCount = 7;
  static const double containerPadding = 2;
  static const double dotWidth = 2;
  static const double indicatorWidth = 28;
  static final double dotSpacing =
      (containerWidth - 2 * containerPadding - (daysCount * dotWidth)) /
          (daysCount - 1);
  static final double dragThreshold = dotSpacing;
  static const double totalDotsWidth = daysCount * dotWidth;
  static const double startingOffset = (indicatorWidth - dotWidth) / 2;
  static const double effectiveContainerWidth = containerWidth - 2 * startingOffset;

  static const double startPoint = containerPadding - 1;
  static const double totalDistance = containerWidth - 2;
  static const double stepSize = totalDistance / daysCount;

  Curve currentCurve = Curves.elasticOut;
  double dragStartX = 0.0;
  bool expanded = false;
  int get tabIndex => widget.indexGetter();

  void onTapDown(TapDownDetails details) {
    setState(() {
      expanded = true;
      widget.overlaySetter(true);
    });
  }

  void resetState() {
    currentCurve = Curves.easeOutExpo;
    setState(() {
      expanded = false;
      widget.overlaySetter(false);
    });
  }

  void onTapUp(TapUpDetails details) => resetState();

  void onLongPressUp() => resetState();

  void onDragStart(DragStartDetails details) {
    currentCurve = Curves.elasticOut;
    dragStartX = details.globalPosition.dx;
    setState(() {
      expanded = true;
      widget.overlaySetter(true);
    });
  }

  void onDragUpdate(DragUpdateDetails details) {
    setState(() {
      final dragOffset = details.globalPosition.dx - dragStartX;

      if (dragOffset.abs() > dragThreshold) {
        if (dragOffset < 0) {
          widget.setIndexPrevious();
        } else {
          widget.setIndexNext();
        }
        dragStartX = details.globalPosition.dx;
      }
    });
  }

  void onDragEnd(DragEndDetails details) {
    resetState();
  }

  double get currentContainerWidth =>
      expanded ? containerWidth + 20 : containerWidth;
  double get currentContainerPadding =>
      expanded ? containerPadding + 10 : containerPadding;

  @override
  Widget build(BuildContext context) {
    // Constants

    // Recalculate spaceBetweenDots
    double spaceBetweenDots =
        (effectiveContainerWidth - totalDotsWidth) / (daysCount - 1);

    double indicatorLeft = startPoint + stepSize * tabIndex;
    return Stack(
      children: [
        GestureDetector(
          onTapDown: onTapDown,
          onTapUp: onTapUp,
          onLongPressUp: onLongPressUp,
          onHorizontalDragStart: onDragStart,
          onHorizontalDragUpdate: onDragUpdate,
          onHorizontalDragEnd: onDragEnd,
          child: AnimatedContainer(
            // width: expanded ? containerWidth + 20 : containerWidth,
            width: currentContainerWidth,
            height: 32,
            curve: currentCurve,
            // padding: EdgeInsets.symmetric(horizontal: expanded ? containerPadding + 10 : containerPadding),
            padding: EdgeInsets.symmetric(horizontal: currentContainerPadding),
            decoration: BoxDecoration(
              color: Color(0xFFD9D9D9),
              borderRadius: BorderRadius.circular(16),
            ),
            duration: const Duration(milliseconds: 500),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: spaceBetweenDots / 2),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(daysCount, (index) {
                        return Container(
                          width: dotWidth,
                          height: dotWidth,
                          decoration: const BoxDecoration(
                            color: Color(0xFF9B9B9B),
                            shape: BoxShape.circle,
                          ),
                        );
                      }),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.easeOutExpo,
                  left: indicatorLeft,
                  top: (32 - indicatorWidth) / 2,
                  child: Container(
                    width: indicatorWidth,
                    height: indicatorWidth,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF15D46),
                      shape: BoxShape.circle,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
