import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_mini/Week%204/S1-Practice/weather_app/enums.dart';
import 'package:flutter_mini/Week%204/S1-Practice/weather_app/weather_service.dart';
import 'package:flutter_mini/Week%204/S1-Practice/weather_app/weather_data.dart';
import 'dart:async';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    color: Colors.white,
    home: WeatherScreen(),
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

  final List<Cities> cities = Cities.values;
  int currentCityIndex = 0;

  Cities get currentCity => cities[currentCityIndex];
  set currentCity(Cities newCity) => currentCityIndex = newCity.index;

  late WeatherData weatherData;
  bool isLoading = true;
  SelectedDay currentDay = SelectedDay.today;
  bool overlay = false;
  bool zoomText = false;
  dynamic selectedDayData = [];

  String message = "";
  void setMessage(String message) {
    setState(() {
      this.message = message;
    });
  }

  String get dynamicMessage {
    if (message != "") return message;
    if (isLoading) return "Loading...";
    if (currentDay == SelectedDay.today) return "Now";
    return "Highest Temperature";
  }

  String get dayString {
    if (isLoading) return currentDay.placeholderName;
    selectedDayData = weatherData.getIntervalDataByDay(currentDay);
    return weatherData.getDayStringFromData(currentDay, selectedDayData);
  }

  WeatherInterval get currentDayInterval {
    return weatherData.getIntervalDataByDay(currentDay);
  }

  WeatherCondition? get weatherCondition {
    if (isLoading) return null;
    return weatherData
        .getWeatherDescription(weatherData.getValueDataByDay(currentDay));
  }

  String get temperatureString {
    if (isLoading) return "--°";
    int temp;
    if (currentDay != SelectedDay.today)
      temp = currentDayValues.temperatureMax.round();
    temp = currentDayValues.temperature.round();

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

  Values get currentDayValues => weatherData.getValueDataByDay(currentDay);

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
    final data =
        await _weatherService.fetchWeatherData(currentCity, setMessage);
    setState(() {
      weatherData = data;
      isLoading = false;
    });
  }

  String get getWindDirectionString {
    if (isLoading) return "--";
    return weatherData
        .getWindDirection(currentDayValues.windDirection)
        .displayString;
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

  void resetDay() {
    setState(() {
      currentDay = SelectedDay.today;
    });
  }

  Widget getConditionImage() {
    WeatherCondition? condition = weatherCondition;
    if (condition == null) {
      return Center(
        child: SizedBox(
          width: 32,
          height: 32,
          child: CircularProgressIndicator(
            color: const Color(0xFFF15D46),
          ),
        ),
      );
    }
    return Image.asset(condition.imagePath);
  }

  bool get isRaining {
    if (isLoading) return false;
    return currentDayValues.rainIntensity > 0.5;
  }

  @override
  void initState() {
    _fetchData();
    timer =
        Timer.periodic(const Duration(minutes: 1), (Timer t) => _fetchData());
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // Widget getWeatherCard() {
  //   if (isLoading) return
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Stack(
            children: [
              Center(
                child: SizedBox(
                  width: 390,
                  child: GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
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
                            vertical: 10,
                            horizontal: 12,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Column(
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
                                    style: const TextStyle(
                                      color: Color(0xFFF15D46),
                                      fontSize: 24,
                                      fontFamily: "Afacad",
                                    ),
                                  ),
                                ],
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
                                    style: const TextStyle(
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
                            vertical: 10,
                            horizontal: 12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                    style: const TextStyle(
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
                                    style: const TextStyle(
                                      color: Color(0xFFF15D46),
                                      fontSize: 18,
                                      fontFamily: "Afacad",
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                    style: const TextStyle(
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
                            vertical: 10,
                            horizontal: 12,
                          ),
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
                                style: const TextStyle(
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
                                  style: const TextStyle(
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
                    opacity: overlay ? 0.75 : 0,
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
                      decoration: const BoxDecoration(
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
                            child: AnimatedScale(
                              scale: zoomText ? 1.5 : 1,
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeOutExpo,
                              child: Text(
                                dayString,
                                style: const TextStyle(
                                  fontFamily: 'Afacad',
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ),
                          ),
                          AnimatedContainer(
                            height: zoomText ? 32 : 6,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeOutExpo,
                          ),
                          Tabs(
                            indexGetter: getDayIndex,
                            overlaySetter: setOverlay,
                            resetIndex: resetDay,
                            setIndexPrevious: setDayPrevious,
                            setIndexNext: setDayNext,
                            zoomSetter: (bool b) => setState(() {
                              zoomText = b;
                              overlay = b;
                            }),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  children: [
                    Container(
                      height: 48,
                      color: Colors.white,
                    ),
                    Container(
                      height: 250,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.7, 1.0],
                          colors: [Colors.white, Color(0x00FFFFFF)],
                        ),
                      ),
                      child: Column(
                        children: [
                          Center(
                            child: Text(
                              temperatureString,
                              style: const TextStyle(
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
                              dynamicMessage,
                              style: const TextStyle(
                                fontFamily: 'Afacad',
                                fontSize: 18,
                                color: Color(0xFF5E5E5E),
                                fontWeight: FontWeight.w700,
                                decoration: TextDecoration.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomLeft,
                child: Transform.translate(
                  offset: Offset(-10, 17),
                  child: RichText(
                    text: const TextSpan(
                      text: "Data provided by ",
                      style: TextStyle(
                          fontFamily: "Afacad",
                          fontSize: 12,
                          color: Colors.black),
                      children: [
                        TextSpan(
                          text: "tomorrow.io",
                          style: TextStyle(
                            color: Color(0xFFF15D46),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: CitySelector(
                  citySetter: setCity,
                  cityGetter: getCity,
                  overlaySetter: setOverlay,
                  allCitiesGetter: () => cities,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Tabs extends StatefulWidget {
  final int Function() indexGetter;
  final void Function() setIndexPrevious;
  final void Function() resetIndex;
  final void Function() setIndexNext;
  final void Function(bool) overlaySetter;
  final void Function(bool) zoomSetter;

  const Tabs({
    required this.indexGetter,
    required this.overlaySetter,
    required this.resetIndex,
    required this.setIndexPrevious,
    required this.setIndexNext,
    required this.zoomSetter,
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

  Curve containerCurve = Curves.elasticOut;
  Curve ballCurve = Curves.easeOutExpo;
  static const Duration ballNormalDuration = Duration(milliseconds: 200);
  static const Duration ballReturnDuration = Duration(milliseconds: 500);
  Duration ballDuration = ballNormalDuration;
  double dragStartX = 0.0;
  bool expanded = false;
  int get tabIndex => widget.indexGetter();

  void onTapDown(TapDownDetails details) =>
      calculateStart(details.globalPosition.dx);

  void resetState() {
    containerCurve = Curves.easeOutExpo;
    setState(() {
      expanded = false;
      widget.zoomSetter(false);
    });
  }

  void onTapUp(TapUpDetails details) {
    widget.resetIndex();
    ballCurve = Curves.elasticOut;
    ballDuration = ballReturnDuration;
    resetState();
  }

  void onLongPressUp() => resetState();

  void onDragStart(DragStartDetails details) =>
      calculateStart(details.globalPosition.dx);

  void onDragEnd(DragEndDetails details) => resetState();

  void onLongPressStart(LongPressStartDetails details) =>
      calculateStart(details.globalPosition.dx);

  void calculateStart(double globalPositionX) {
    containerCurve = Curves.elasticOut;
    ballCurve = Curves.easeOutExpo;
    ballDuration = ballNormalDuration;
    dragStartX = globalPositionX;
    setState(() {
      expanded = true;
      widget.zoomSetter(true);
    });
  }

  void calculateMovement(double globalPositionX) {
    setState(() {
      final dragOffset = globalPositionX - dragStartX;

      if (dragOffset.abs() > dragThreshold) {
        if (dragOffset < 0) {
          widget.setIndexPrevious();
        } else {
          widget.setIndexNext();
        }
        dragStartX = globalPositionX;
      }
    });
  }

  void onLongPressMoveUpdate(LongPressMoveUpdateDetails details) =>
      calculateMovement(details.globalPosition.dx);
  void onDragUpdate(DragUpdateDetails details) =>
      calculateMovement(details.globalPosition.dx);

  double get currentContainerWidth =>
      expanded ? containerWidth + 20 : containerWidth;
  double get currentContainerPadding =>
      expanded ? containerPadding + 10 : containerPadding;

  @override
  Widget build(BuildContext context) {
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
          onLongPressStart: onLongPressStart,
          onLongPressMoveUpdate: onLongPressMoveUpdate,
          child: AnimatedContainer(
            width: currentContainerWidth,
            height: 32,
            curve: containerCurve,
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
                      children: List.generate(
                        daysCount,
                        (index) {
                          return Container(
                            width: dotWidth,
                            height: dotWidth,
                            decoration: const BoxDecoration(
                              color: Color(0xFF9B9B9B),
                              shape: BoxShape.circle,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  duration: ballDuration,
                  curve: ballCurve,
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
  final List<Cities> Function() allCitiesGetter;

  const CitySelector({
    required this.citySetter,
    required this.cityGetter,
    required this.overlaySetter,
    required this.allCitiesGetter,
    super.key,
  });

  @override
  State<CitySelector> createState() => _CitySelectorState();
}

class _CitySelectorState extends State<CitySelector> {
  bool opened = false;

  void toggleOpen() {
    setState(() {
      opened = !opened;
      widget.overlaySetter(opened);
    });
  }

  void nextCity() {
    setState(() {
      int cityLength = Cities.values.length;
      int currentCityIndex = widget.cityGetter().index;
      Cities newCity = Cities.values[(currentCityIndex + 1) % cityLength];

      widget.citySetter(newCity);
    });
  }

  List<Widget> citiesList() {
    List<Cities> allCities = widget.allCitiesGetter();
    final List<Widget> children = [
      const Divider(),
    ];

    children.addAll(
      List.generate(
        allCities.length,
        (index) {
          return TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontFamily: "FiraMono"),
              foregroundColor: Colors.black,
              backgroundColor: widget.cityGetter().index == index
                  ? const Color(0x0E000000)
                  : null,
            ),
            onPressed: () {
              setState(() {
                widget.citySetter(allCities[index]);
                toggleOpen();
              });
            },
            child: Center(child: Text(allCities[index].displayName)),
          );
        },
      ),
    );

    return children;
  }

  @override
  Widget build(BuildContext context) {
    List<Cities> allCities = widget.allCitiesGetter();
    final double height = 260;
    return AnimatedContainer(
      height: opened ? height : 48, // Static height
      width: 390,
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: opened ? const Color(0xEEEEEEEE) : null,
      ),
      curve: Curves.easeOutExpo,
      child: Column(
        children: [
          TextButton(
            style: TextButton.styleFrom(
              textStyle: const TextStyle(fontFamily: "FiraMono"),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(opened ? 8 : 16))
            ),
            onPressed: toggleOpen,
            child: Center(child: Text(widget.cityGetter().displayName)),
          ),
          AnimatedOpacity(
            opacity: opened ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutExpo,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Divider(),
                ),
                AnimatedContainer(
                  height: opened ? height - 48 : 0,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutExpo,
                  child: ListView(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    children: List.generate(
                      allCities.length,
                      (index) {
                        return TextButton(
                          style: TextButton.styleFrom(
                            textStyle: const TextStyle(fontFamily: "FiraMono"),
                            foregroundColor: Colors.black,
                            backgroundColor: widget.cityGetter().index == index
                                ? const Color(0x0E000000)
                                : null,
                          ),
                          onPressed: () {
                            setState(() {
                              widget.citySetter(allCities[index]);
                              toggleOpen();
                            });
                          },
                          child:
                              Center(child: Text(allCities[index].displayName)),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
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
