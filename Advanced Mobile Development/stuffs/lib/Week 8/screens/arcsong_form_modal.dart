import 'package:flutter/material.dart';
import 'package:stuffs/Week%208/models/arcsong.dart';
import 'package:stuffs/Week%208/models/difficulty.dart';
import 'package:stuffs/Week%208/models/enums.dart';

class ArcsongFormScreen extends StatefulWidget {
  final Arcsong? initArcsong;

  const ArcsongFormScreen(this.initArcsong, {super.key});

  @override
  State<ArcsongFormScreen> createState() => _ArcsongFormState();
}

class _ArcsongFormState extends State<ArcsongFormScreen> {
  final _formKey = GlobalKey<FormState>();

  String _titleEn = '';
  String _titleJa = '';
  String _artist = '';
  String _bg = '';
  String _bpm = '';
  double _bpmBase = 200.0;
  String _packId = '';
  Side _side = Side.light;
  String _version = '';

  bool _hasPast = true;
  int _pastRating = 0;
  bool _pastRatingPlus = false;
  String _pastChartDesigner = '';
  String _pastJacketDesigner = '';

  bool _hasPresent = true;
  int _presentRating = 0;
  bool _presentRatingPlus = false;
  String _presentChartDesigner = '';
  String _presentJacketDesigner = '';

  bool _hasFuture = true;
  int _futureRating = 0;
  bool _futureRatingPlus = false;
  String _futureChartDesigner = '';
  String _futureJacketDesigner = '';

  bool _hasBeyond = false;
  int _beyondRating = 0;
  bool _beyondRatingPlus = false;
  String _beyondChartDesigner = '';
  String _beyondJacketDesigner = '';

  bool _hasEternal = false;
  int _eternalRating = 0;
  bool _eternalRatingPlus = false;
  String _eternalChartDesigner = '';
  String _eternalJacketDesigner = '';

  @override
  void initState() {
    if (widget.initArcsong != null) initFormData(widget.initArcsong!);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ArcsongFormScreen oldWidget) {
    if (widget.initArcsong != null) initFormData(widget.initArcsong!);
    super.didUpdateWidget(oldWidget);
  }

  void initFormData(Arcsong initArcsong) {
    _titleEn = initArcsong.title.en;
    _titleJa = initArcsong.title.ja ?? '';
    _artist = initArcsong.artist;
    _bg = initArcsong.bg;
    _bpm = initArcsong.bpm;
    _bpmBase = initArcsong.bpmBase;
    _packId = initArcsong.packId;
    _side = initArcsong.side;
    _version = initArcsong.version;

    _hasPast = false;
    _hasPresent = false;
    _hasFuture = false;
    _hasBeyond = false;
    _hasEternal = false;

    for (Difficulty diff in initArcsong.difficulties) {
      switch (diff.ratingClass) {
        case RatingClass.past:
          _pastRating = diff.rating;
          _pastRatingPlus = diff.ratingPlus ?? false;
          _pastChartDesigner = diff.chartDesigner;
          _pastJacketDesigner = diff.jacketDesigner;
          _hasPast = true;
          break;
        case RatingClass.present:
          _presentRating = diff.rating;
          _presentRatingPlus = diff.ratingPlus ?? false;
          _presentChartDesigner = diff.chartDesigner;
          _presentJacketDesigner = diff.jacketDesigner;
          _hasPresent = true;
          break;
        case RatingClass.future:
          _futureRating = diff.rating;
          _futureRatingPlus = diff.ratingPlus ?? false;
          _futureChartDesigner = diff.chartDesigner;
          _futureJacketDesigner = diff.jacketDesigner;
          _hasFuture = true;
          break;
        case RatingClass.beyond:
          _beyondRating = diff.rating;
          _beyondRatingPlus = diff.ratingPlus ?? false;
          _beyondChartDesigner = diff.chartDesigner;
          _beyondJacketDesigner = diff.jacketDesigner;
          _hasBeyond = true;
          break;
        case RatingClass.eternal:
          _eternalRating = diff.rating;
          _eternalRatingPlus = diff.ratingPlus ?? false;
          _eternalChartDesigner = diff.chartDesigner;
          _eternalJacketDesigner = diff.jacketDesigner;
          _hasEternal = true;
          break;
      }
    }
  }

  void _saveForm() {
    bool isValid = _formKey.currentState!.validate();

    if (isValid) {
      _formKey.currentState!.save();
    }
  }

  void _resetForm() {
    _formKey.currentState!.reset();
  }

  @override
  Widget build(BuildContext context) {
    String title;
    String submit;
    if (widget.initArcsong == null) {
      title = "Add a new arcsong";
      submit = "Submit";
    } else {
      title = "Edit an arcsong";
      submit = "Edit";
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        // padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _titleEn,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title in English'),
                ),
                validator: _validateString,
                onSaved: (newValue) => _titleEn = newValue!,
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _titleJa,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Title in Japanese'),
                ),
                validator: _validateString,
                onSaved: (newValue) => _titleJa = newValue!,
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _artist,
                maxLength: 50,
                decoration: const InputDecoration(
                  label: Text('Artist name'),
                ),
                validator: _validateString,
                onSaved: (newValue) => _artist = newValue!,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<Side>(
                value: _side,
                validator: (value) {
                  if (value == null) return "Select a category";
                  return null;
                },
                items: [
                  for (Side side in Side.values)
                    DropdownMenuItem<Side>(
                      value: side,
                      child: Text(
                        side.label,
                        style: TextStyle(color: side.color),
                      ),
                    ),
                ],
                onChanged: (value) => _side = value ?? Side.light,
              ),
              const SizedBox(height: 12),
              TextFormField(
                initialValue: _version,
                maxLength: 10,
                decoration: const InputDecoration(
                  label: Text('Version'),
                ),
                validator: _validateVersionString,
                onSaved: (newValue) => _version = newValue!,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  TextFormField(
                    initialValue: _bg,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('Background ID'),
                    ),
                    validator: _validateString,
                    onSaved: (newValue) => _bg = newValue!,
                  ),
                  const SizedBox(width: 8),
                  TextFormField(
                    initialValue: _packId,
                    maxLength: 50,
                    decoration: const InputDecoration(
                      label: Text('Pack ID'),
                    ),
                    validator: _validateString,
                    onSaved: (newValue) => _packId = newValue!,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  TextFormField(
                    initialValue: _bpm,
                    maxLength: 32,
                    decoration: const InputDecoration(
                      label: Text('BPM label'),
                    ),
                    validator: _validateString,
                    onSaved: (newValue) => _artist = newValue!,
                  ),
                  const SizedBox(width: 8),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    initialValue: _bpmBase.toString(),
                    maxLength: 32,
                    decoration: const InputDecoration(
                      label: Text('Base BPM'),
                    ),
                    validator: _validatePositiveDouble,
                    onSaved: (newValue) => _bpmBase = double.parse(newValue!),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? _validatePositiveDouble(String? newValue) {
    double? value = double.tryParse(newValue ?? '');

    if (value == null)
      return 'Must be a double.';
    else if (value.isNegative) return 'Must be a positive number.';
    return null;
  }

  String? _validateString(String? newValue) {
    if (newValue == null || newValue.trim().length <= 1) {
      return 'Cannot be empty';
    }
    return null;
  }

  String? _validateVersionString(String? newValue) {
    if (newValue == null || newValue.trim().length <= 1) {
      return 'Cannot be empty';
    }

    List<String> versions = newValue.trim().split('.');

    if (versions.length != 2) return 'Invalid version string';

    for (String value in versions) {
      double? version = double.tryParse(value);

      if (version == null)
        return 'Must be a double.';
      else if (version.isNegative) return 'Must be a positive number.';
    }
    return null;
  }
}
