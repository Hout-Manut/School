class Distance {
  late final double _meter;

  Distance({
    double mm = 0,
    double cm = 0,
    double dm = 0,
    double m = 0,
    double dam = 0,
    double hm = 0,
    double km = 0,
    double inch = 0,
    double yard = 0,
    double foot = 0,
    double mile = 0,
  }) {
    double value = 0;
    value += mm / 1000;
    value += cm / 100;
    value += dm / 10;
    value += m;
    value += dam * 10;
    value += hm * 100;
    value += km * 1000;
    value += inch / 39.3701;
    value += yard / 1.09361;
    value += foot / 3.28084;
    value += mile * 1609.34;
    _meter = value;
  }

  Distance.mm(double mm) : this._meter = mm / 1000;

  Distance.cm(double cm) : this._meter = cm / 100;

  Distance.dm(double dm) : this._meter = dm / 10;

  Distance.m(double m) : this._meter = m;

  Distance.dam(double dam) : this._meter = dam * 10;

  Distance.hm(double hm) : this._meter = hm * 100;

  Distance.km(double km) : this._meter = km * 1000;

  Distance.inch(double inch) : this._meter = inch / 39.3701;

  Distance.yard(double yard) : this._meter = yard / 1.09361;

  Distance.foot(double foot) : this._meter = foot / 3.28084;

  Distance.mile(double mile) : this._meter = mile * 1609.34;

  Distance operator +(Distance other) =>
      Distance.m(this._meter + other._meter);

  @override
  bool operator ==(covariant Distance other) => this._meter == other._meter;

  bool operator >(Distance other) => this._meter > other._meter;

  bool operator >=(Distance other) => this._meter >= other._meter;

  bool operator <(Distance other) => this._meter < other._meter;

  bool operator <=(Distance other) => this._meter <= other._meter;

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
  double get inch => _meter * 39.3701;
  double get foot => _meter * 3.28084;
  double get yard => _meter * 1.09361;
  double get mile => _meter / 1609.34;
}

void main() {
  Distance d1 = Distance();
  print(d1);
}
