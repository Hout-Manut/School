import 'package:flutter/material.dart';

import '../models/course_model.dart';

const Color mainColor = Colors.blue;

class CourseScoreForm extends StatefulWidget {
  const CourseScoreForm({super.key});

  @override
  State<CourseScoreForm> createState() {
    return _CourseScoreFormState();
  }
}

class _CourseScoreFormState extends State<CourseScoreForm> {
  final _formKey = GlobalKey<FormState>();

  late String _enteredName;
  late double _enteredScore;

  @override
  void initState() {
    super.initState();
    _enteredName = '';
    _enteredScore = 50;
  }

  void _saveItem() {
    bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();
      Navigator.of(
        context,
      ).pop(CourseScore(studentName: _enteredName, studentScore: _enteredScore));
    }
  }

  String? validateName(String? value) {
    if (value == null ||
        value.isEmpty ||
        value.trim().length <= 1 ||
        value.trim().length > 50) {
      return 'Must be between 1 and 50 characters.';
    }
    return null;
  }

  String? validateScore(String? value) {
    if (value == null ||
        value.isEmpty ||
        double.tryParse(value) == null ||
        double.tryParse(value)! < 0 ||
        double.tryParse(value)! > 100) {
      return 'Must be a score bteween 0 and 100';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: mainColor,
        title: const Text("Add Score", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                initialValue: _enteredName,
                maxLength: 50,
                decoration: const InputDecoration(label: Text('Name')),
                validator: validateName,
                onSaved: (value) {
                  _enteredName = value!;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(label: Text('Score')),
                initialValue: _enteredScore.toString(),
                validator: validateScore,
                onSaved: (value) {
                  _enteredScore = double.parse(value!);
                },
              ),
              const Expanded(child: SizedBox(height: 12)),
              ElevatedButton(
                onPressed: _saveItem,
                child: const Text("Add score"),
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
