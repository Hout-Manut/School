import 'package:flutter/material.dart';

import '../models/course.dart';

class ScoreForm extends StatefulWidget {
  final void Function(StudentScore) onCreate;
  const ScoreForm({super.key, required this.onCreate});

  @override
  State<ScoreForm> createState() => _ScoreFormState();
}

class _ScoreFormState extends State<ScoreForm> {
  final _formKey = GlobalKey<FormState>();

  String _name = '';
  String _score = '0';

  String? _validateName(String? newName) {
    if (newName == null) {
      return "Must be a valid string";
    }
    if (newName.isEmpty) {
      return "Must be between 0 and 50";
    }
    return null;
  }

  String? _validateScore(String? newScoreStr) {
    double? newScore =
        newScoreStr != null ? double.tryParse(newScoreStr) : null;

    if (newScore == null) {
      return "Must be a valid number";
    }
    if (newScore < 0 || newScore > 100) {
      return "Must be a score between 0 and 100";
    }
    return null;
  }

  void _saveItem() {
    bool isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();

      StudentScore newScore =
          StudentScore(name: _name, score: double.parse(_score));
      widget.onCreate(newScore);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Score"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _name,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Name'),
                ),
                validator: _validateName,
                onSaved: (value) {
                  _name = value!;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: _score,
                validator: _validateScore,
                decoration: const InputDecoration(
                  label: Text('Quantity'),
                ),
                onSaved: (value) {
                  _score = value!;
                },
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                    child: const Text('Reset'),
                  ),
                  ElevatedButton(
                    onPressed: _saveItem,
                    child: Text("Add Score"),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
