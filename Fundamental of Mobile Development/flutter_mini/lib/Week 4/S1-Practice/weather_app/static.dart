import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

const double roundThingHeight = 28;

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Container(
          padding: EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 100),
          color: Colors.white,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 160, bottom: 50),
                child: SingleChildScrollView(
                  padding: EdgeInsets.only(top: 120, bottom: 40),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        HeaderText("Conditions"),
                        SubText("H: 32° L: 24°"),
                        SubText("Feels like 34°"),
                        SizedBox(height: 70),
                        SubText("Pretend this is a cool graph"),
                        SizedBox(height: 120),
                        HeaderText("Precipitation"),
                        SubText("0% Chance"),
                        SizedBox(height: 150),
                        HeaderText("Humidity"),
                        SubText("70% Humid"),
                        SubText("c"),
                        SubText("c"),
                        SubText("c"),
                        SubText("c"),
                        SubText("c"),
                        SubText("c"),
                      ]),
                ),
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
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Center(
                        child: Text(
                          "Phnom Penh",
                          style: TextStyle(
                            fontFamily: 'FiraMono',
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          "25°",
                          style: TextStyle(
                            fontFamily: 'AdventPro',
                            fontSize: 108,
                            color: Color(0xFFF15D46),
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: Text(
                          "Cloudy",
                          style: TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 24,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      stops: [0.8, 1.0],
                      colors: [Colors.white, Color(0x00FFFFFF)],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Center(
                        child: Text(
                          "Today",
                          style: TextStyle(
                            fontFamily: 'Afacad',
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        padding: EdgeInsets.all(2),
                        height: roundThingHeight + 4,
                        width: (roundThingHeight * 7) + 4,
                        decoration: BoxDecoration(
                          color: Color(0xFFD9D9D9),
                          borderRadius:
                              BorderRadius.circular((roundThingHeight + 4) / 2),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            RoundThing(active: false),
                            RoundThing(active: true),
                            RoundThing(active: false),
                            RoundThing(active: false),
                            RoundThing(active: false),
                            RoundThing(active: false),
                            RoundThing(active: false),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class HeaderText extends StatelessWidget {
  final String data;
  const HeaderText(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontFamily: "Afacad",
        fontWeight: FontWeight.w700,
        fontSize: 24,
        color: Colors.black,
        decoration: TextDecoration.none,
      ),
    );
  }
}

class SubText extends StatelessWidget {
  final String data;
  const SubText(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontFamily: "Afacad",
        fontWeight: FontWeight.w400,
        fontSize: 16,
        color: Colors.black,
        decoration: TextDecoration.none,
      ),
    );
  }
}

class RoundThing extends StatelessWidget {
  final bool active;

  const RoundThing({super.key, required this.active});

  Widget getChild() {
    if (active) {
      return Container(
        width: roundThingHeight,
        height: roundThingHeight,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(roundThingHeight / 2),
          color: Color(0xFFF15D46),
        ),
      );
    } else {
      return Center(
        child: Container(
          width: 2,
          height: 2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(roundThingHeight / 2),
            color: Color(0xFF9B9B9B),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: roundThingHeight,
      width: roundThingHeight,
      child: getChild(),
    );
  }
}
