class Distance {
  late final double _meter;

  Distance.mm(double mm) : this._meter = mm / 1000;

  Distance.cm(double cm) : this._meter = cm / 100;

  Distance.dm(double dm) : this._meter = dm / 10;

  Distance.m(double m) : this._meter = m;

  Distance.dam(double dam) : this._meter = dam * 10;

  Distance.hm(double hm) : this._meter = hm * 100;

  Distance.km(double km) : this._meter = km * 1000;

  Distance operator +(covariant Distance other) =>
      Distance.m(this._meter + other._meter);

  @override
  bool operator ==(covariant Distance other) => this._meter == other._meter;

  bool operator >(covariant Distance other) => this._meter > other._meter;

  bool operator >=(covariant Distance other) => this._meter >= other._meter;

  bool operator <(covariant Distance other) => this._meter < other._meter;

  bool operator <=(covariant Distance other) => this._meter <= other._meter;

  @override
  String toString() {
    return "Distance(${_meter}m)";
  }

  double get mm => _meter * 1000;
  double get cm => _meter * 100;
  double get dm => _meter * 10;
  double get m => _meter;
  double get dam => _meter / 10;
  double get hm => _meter / 100;
  double get km => _meter / 1000;
}

void main() {
  Distance d1 = Distance.km(3.4);
  Distance d2 = Distance.m(1000);

  print((d1 + d2).km);
}
