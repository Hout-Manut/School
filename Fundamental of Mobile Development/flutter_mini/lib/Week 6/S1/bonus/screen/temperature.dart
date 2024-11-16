import 'package:flutter/material.dart';

class Temperature extends StatefulWidget {
  const Temperature({super.key});

  @override
  State<Temperature> createState() => _TemperatureState();
}

class _TemperatureState extends State<Temperature> {
  double celsius = 37;

  double get fahrenheit => (celsius * 9 / 5) + 32;
  set fahrenheit(double value) => celsius = (value - 32) * 5 / 9;

  bool celsiusError = false;
  bool fahrenheitError = false;

  final BoxDecoration textDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
  );

  final InputDecoration inputDecoration = InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 1.0),
        borderRadius: BorderRadius.circular(12),
      ),
      hintText: 'Enter a temperature',
      hintStyle: const TextStyle(color: Colors.white));

  void onCChange(String newValue) {
    setState(() {
      double value = 0.0;
      if (newValue != "") {
        try {
          value = double.parse(newValue);
        } catch (e) {
          celsiusError = true;
          return;
        }
      }
      celsius = value;
      celsiusError = false;
    });
  }

  void onFChange(String newValue) {
    setState(() {
      double value = 0.0;
      if (newValue != "") {
        try {
          value = double.parse(newValue);
        } catch (e) {
          fahrenheitError = true;
          return;
        }
      }
      fahrenheit = value;
      fahrenheitError = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(
            Icons.thermostat_outlined,
            size: 120,
            color: Colors.white,
          ),
          const Center(
            child: Text(
              "Converter",
              style: TextStyle(color: Colors.white, fontSize: 45),
            ),
          ),
          const SizedBox(height: 50),
          const Text("Temperature in Degrees:"),
          const SizedBox(height: 10),
          TextField(
              onChanged: onCChange,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: celsiusError ? Colors.red : Colors.purple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: celsius.toString(),
                  hintStyle: const TextStyle(color: Colors.white)),
              style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 30),
          const Text("Temperature in Fahrenheit:"),
          const SizedBox(height: 10),
          TextField(
              keyboardType: TextInputType.number,
              onChanged: onFChange,
              decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: fahrenheitError ? Colors.red : Colors.purple),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(color: Colors.white, width: 1.0),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: fahrenheit.toString(),
                  hintStyle: const TextStyle(color: Colors.white)),
              style: const TextStyle(color: Colors.white)),
        ],
      )),
    );
  }
}
