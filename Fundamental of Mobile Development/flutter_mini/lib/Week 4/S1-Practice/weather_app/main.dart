import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_mini/Week%204/S1-Practice/weather_app/enums.dart';
import 'package:flutter_mini/Week%204/S1-Practice/weather_app/weather_service.dart';
import 'package:flutter_mini/Week%204/S1-Practice/weather_app/weather_data.dart';
import 'dart:async';

import 'dart:math';

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
  Timer? timer;

  late WeatherData weatherData;
  bool isLoading = true;
  SelectedDay currentDay = SelectedDay.today;
  bool overlay = false;
  dynamic selectedDayData = [];
  Cities currentCity = Cities.phnomPenh;

  String get dayString {
    if (isLoading) return "Loading...";
    selectedDayData = weatherData.getIntervalDataByDay(currentDay);
    return weatherData.getDayStringFromData(currentDay, selectedDayData);
  }

  WeatherInterval get currentDayInterval {
    return weatherData.getIntervalDataByDay(currentDay);
  }

  String get weatherDescription {
    if (isLoading) return "Loading...";
    return weatherData.getWeatherDescription(
        weatherData.getIntervalDataByDay(currentDay).values);
  }

  String get temperatureString {
    if (isLoading) return "--°";
    int temp = currentDayValues.temperature.round();

    return "$temp°";
  }

  String get temperatureApparentString {
    if (isLoading) return "--°";
    int temp = currentDayValues.temperatureApparent.round();

    return "$temp°";
  }

  String get minMaxTempString {
    if (isLoading) return "--°";
    int minTemp = currentDayValues.temperatureMin.round();
    int maxTemp = currentDayValues.temperatureMax.round();

    return "H:$maxTemp° L:$minTemp°";
  }

  void setCity(Cities newCity) {
    currentCity = newCity;
    clearAndFetchData();
  }

  Cities getCity() => currentCity;

  Values get currentDayValues =>
      weatherData.getIntervalDataByDay(currentDay).values;

  Future<void> clearAndFetchData() async {
    setState(() {
      isLoading = true;
    });
    await _fetchData();
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

  Future<void> _fetchData() async {
    final data = await _weatherService.fetchWeatherData(currentCity);
    setState(() {
      weatherData = data;
      isLoading = false;
    });
  }

  String get getWindDirectionString {
    if (isLoading) return "--";
    return weatherData
        .getWindDirection(currentDayValues.windDirection)
        .name
        .toUpperCase();
  }

  String get chanceOfRainString {
    if (isLoading) return "--";
    double chance = currentDayValues.precipitationProbability;
    return "$chance%";
  }

  String get windSpeed {
    if (isLoading) return "-- km/h";
    double speed = currentDayValues.windSpeed;
    return "$speed kh/h";
  }

  String get gustSpeed {
    if (isLoading) return "-- km/h";
    double speed = currentDayValues.windGust;
    return "$speed kh/h";
  }

  Widget getConditionImage() {
    if (isLoading) {
      return Center(
        child: SizedBox(
          width: 64,
          height: 64,
          child: CircularProgressIndicator(),
        ),
      );
    }
    String condition = weatherDescription;
    return Image.asset("assets/images/weather/$condition.png");
  }

  bool get isRaining {
    if (isLoading) return false;
    return currentDayValues.rainIntensity > 0.5;
  }

  @override
  void initState() {
    _fetchData();
    timer = Timer.periodic(Duration(seconds: 30), (Timer t) => _fetchData());
    super.initState();
  }

  // Widget getWeatherCard() {
  //   if (isLoading) return
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                width: 390,
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 items per row
                    mainAxisSpacing: 10, // spacing between rows
                    crossAxisSpacing: 10, // spacing between columns
                  ),
                  children: [
                    const SizedBox(height: 200, width: 200), // Padding
                    const SizedBox(height: 200, width: 200),
                    const SizedBox(height: 200, width: 200),
                    const SizedBox(height: 200, width: 200),
                    WeatherConditionCard(getConditionImage()),
                    CustomWeatherCard(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              "Temperature",
                              style: TextStyle(
                                color: Color(0xFF717171),
                                fontSize: 12,
                                fontFamily: "Afacad",
                              ),
                            ),
                            Text(
                              textAlign: TextAlign.left,
                              minMaxTempString,
                              style: TextStyle(
                                color: Color(0xFFF15D46),
                                fontSize: 24,
                                fontFamily: "Afacad",
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Text(
                                  "Feels like",
                                  style: TextStyle(
                                    color: Color(0xFF717171),
                                    fontSize: 12,
                                    fontFamily: "Afacad",
                                  ),
                                ),
                                Text(
                                  temperatureApparentString,
                                  style: TextStyle(
                                    color: Color(0xFFF15D46),
                                    fontSize: 24,
                                    fontFamily: "Afacad",
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomWeatherCard(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Wind Speed",
                                  style: TextStyle(
                                    color: Color(0xFF717171),
                                    fontSize: 12,
                                    fontFamily: "Afacad",
                                  ),
                                ),
                                Text(
                                  windSpeed,
                                  style: TextStyle(
                                    color: Color(0xFFF15D46),
                                    fontSize: 18,
                                    fontFamily: "Afacad",
                                  ),
                                ),
                                const Text(
                                  "Gust Speed",
                                  style: TextStyle(
                                    color: Color(0xFF717171),
                                    fontSize: 12,
                                    fontFamily: "Afacad",
                                  ),
                                ),
                                Text(
                                  gustSpeed,
                                  style: TextStyle(
                                    color: Color(0xFFF15D46),
                                    fontSize: 18,
                                    fontFamily: "Afacad",
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  "Direction",
                                  style: TextStyle(
                                    color: Color(0xFF717171),
                                    fontSize: 12,
                                    fontFamily: "Afacad",
                                  ),
                                ),
                                Text(
                                  getWindDirectionString,
                                  style: TextStyle(
                                    color: Color(0xFFF15D46),
                                    fontSize: 24,
                                    fontFamily: "Afacad",
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    CustomWeatherCard(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const Text(
                              "Chance of Rain",
                              style: TextStyle(
                                color: Color(0xFF717171),
                                fontSize: 12,
                                fontFamily: "Afacad",
                              ),
                            ),
                            Text(
                              chanceOfRainString,
                              style: TextStyle(
                                color: Color(0xFF009CBF),
                                fontSize: 36,
                                fontFamily: "Afacad",
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    if (isRaining)
                      CustomWeatherCard(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              const Text(
                                "Rain Intensity",
                                style: TextStyle(
                                  color: Color(0xFF717171),
                                  fontSize: 12,
                                  fontFamily: "Afacad",
                                ),
                              ),
                              Text(
                                currentDayValues.rainIntensity.toString(),
                                style: TextStyle(
                                  color: Color(0xFF009CBF),
                                  fontSize: 36,
                                  fontFamily: "Afacad",
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 50, width: 50),
                    const SizedBox(height: 50, width: 50),
                  ],
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
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        stops: [0.7, 1.0],
                        colors: [Colors.white, Color(0x00FFFFFF)],
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Text(
                            dayString,
                            style: TextStyle(
                              fontFamily: 'Afacad',
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Tabs(
                          indexGetter: getDayIndex,
                          overlaySetter: setOverlay,
                          setIndexPrevious: setDayPrevious,
                          setIndexNext: setDayNext,
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 250,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.7, 1.0],
                    colors: [Colors.white, Color(0x00FFFFFF)],
                  ),
                ),
                child: Column(
                  children: [
                    CitySelector(
                      citySetter: setCity,
                      cityGetter: getCity,
                      overlaySetter: setOverlay,
                    ),
                    Center(
                      child: Text(
                        temperatureString,
                        style: TextStyle(
                          fontFamily: 'AdventPro',
                          fontSize: 108,
                          color: Color(0xFFF15D46),
                          fontWeight: FontWeight.w400,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                    Center(
                      child: Text(
                        // "Cloudy",
                        weatherDescription,
                        style: TextStyle(
                          fontFamily: 'Afacad',
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
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
  static final double dragThreshold = dotSpacing * 0.9;
  static const double totalDotsWidth = daysCount * dotWidth;
  static const double startingOffset = (indicatorWidth - dotWidth) / 2;
  static const double effectiveContainerWidth =
      containerWidth - 2 * startingOffset;

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

class CitySelector extends StatefulWidget {
  final void Function(Cities) citySetter;
  final void Function(bool) overlaySetter;
  final Cities Function() cityGetter;

  const CitySelector({
    required this.citySetter,
    required this.cityGetter,
    required this.overlaySetter,
    super.key,
  });

  @override
  State<CitySelector> createState() => _CitySelectorState();
}

class _CitySelectorState extends State<CitySelector> {
  bool opened = false;

  // void toggleOpen() => opened = !opened;

  void getRandomCity() {
    setState(() {
      int result = Random().nextInt(Cities.values.length);
      Cities newCity = Cities.values[result];
      widget.citySetter(newCity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          IntrinsicWidth(
            child: TextButton(
              style: TextButton.styleFrom(
                textStyle: TextStyle(fontFamily: "FiraMono"),
                foregroundColor: Colors.black,
              ),
              onPressed: getRandomCity,
              child: Center(child: Text(widget.cityGetter().displayName)),
            ),
          ),
        ],
      ),
    );
  }
}

class WeatherConditionCard extends WeatherCard {
  final Widget image;
  const WeatherConditionCard(this.image, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: WeatherCard.cardSize,
      height: WeatherCard.cardSize,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(WeatherCard.borderRadius)),
      child: image,
    );
  }
}

class CustomWeatherCard extends WeatherCard {
  final Widget child;

  const CustomWeatherCard({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: WeatherCard.cardSize,
      height: WeatherCard.cardSize,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(WeatherCard.borderRadius),
        color: WeatherCard.color,
      ),
      child: child,
    );
  }
}

abstract class WeatherCard extends StatelessWidget {
  static const double cardSize = 176;
  static const double borderRadius = 16;
  static const Color color = Color(0xFFEFEFEF);
  const WeatherCard({super.key});
}
