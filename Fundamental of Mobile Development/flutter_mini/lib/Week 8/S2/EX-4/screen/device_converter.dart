import 'package:flutter/material.dart';

import '../devices/devices.dart';

class DeviceConverter extends StatefulWidget {
  const DeviceConverter({super.key});

  @override
  State<DeviceConverter> createState() => _DeviceConverterState();
}

class _DeviceConverterState extends State<DeviceConverter> {
  Device _selectedDevice = Device.khr;

  double get dollarValue {
    String dollarString = _valueController.text;
    dollarString = dollarString == "" ? "0" : dollarString;
    return double.parse(dollarString);
  }

  final BoxDecoration textDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
  );

  // a direct copy from the last exercise
  final _valueController = TextEditingController();
  final _valueRegExp = RegExp(r'^\d*\.?\d*$');
  String _lastValue = "";
  void filterValueInput(String newString) {
    TextSelection cursorLocation = _valueController.selection;
    if (_valueRegExp.hasMatch(newString)) {
      _valueController.text = newString;
      _valueController.selection =
          TextSelection.collapsed(offset: cursorLocation.baseOffset);
      _lastValue = newString;
      setState(() {});
    } else {
      _valueController.text = _lastValue;
    }
  }

  void update() {}

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
            Icons.money,
            size: 60,
            color: Colors.white,
          ),
          const Center(
            child: Text(
              "Converter",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
          ),
          const SizedBox(height: 50),
          const Text("Amount in dollars:"),
          const SizedBox(height: 10),
          TextField(
            controller: _valueController,
            decoration: InputDecoration(
                prefix: const Text('\$'),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white, width: 1.0),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Enter an amount in dollar',
                hintStyle: const TextStyle(color: Colors.white)),
            style: const TextStyle(color: Colors.white),
            onChanged: filterValueInput,
          ),
          const SizedBox(height: 30),
          const Text("Device:"),
          const SizedBox(height: 10),
          DropdownButton(
            value: _selectedDevice,
            onChanged: (Device? newDevice) =>
                setState(() => _selectedDevice = newDevice!),
            elevation: 16,
            style: const TextStyle(color: Colors.white),
            underline: Container(
              height: 2,
              color: Colors.white,
            ),
            items: Device.values
                .map<DropdownMenuItem<Device>>(
                  (device) => DropdownMenuItem<Device>(
                    value: device,
                    child: Text(
                      device.name.toUpperCase(),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 30),
          const Text("Amount in selected device:"),
          const SizedBox(height: 10),
          ConvertedWidget(device: _selectedDevice, dollarValue: dollarValue)
        ],
      )),
    );
  }
}

class ConvertedWidget extends StatelessWidget {
  final Device device;
  final double dollarValue;
  const ConvertedWidget({
    super.key,
    required this.device,
    required this.dollarValue,
  });

  List<Widget> buildValue() {
    List<Widget> children = [];

    if (device.direction == SymbolDirection.before) {
      children.add(Text(device.symbol));
    }
    children.add(Text(device.fromDollar(dollarValue).toStringAsFixed(2)));
    if (device.direction == SymbolDirection.after) {
      children.add(Text(device.symbol));
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(children: buildValue()),
    );
  }
}
