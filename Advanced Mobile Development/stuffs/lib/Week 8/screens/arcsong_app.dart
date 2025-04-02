import 'package:flutter/material.dart';
import 'package:stuffs/Week%208/screens/arcsong_form_modal.dart';

class ArcsongApp extends StatelessWidget {
  const ArcsongApp({super.key});

  void _onAddPressed(BuildContext context) async {
    await Navigator.of(context).push(MaterialPageRoute(builder: (context) => ArcsongFormScreen(null)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        actions: [
          IconButton(
              onPressed: () => _onAddPressed(context),
              icon: const Icon(Icons.add))
        ],
      ),
      body: Center(
        child: Placeholder(),
      ),
    );
  }
}
