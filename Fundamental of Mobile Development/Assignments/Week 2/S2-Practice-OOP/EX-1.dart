enum Skill { FLUTTER, DART, OTHER }

enum Country { CAMBODIA, FRANCE, USA }

Map<Skill, double> skillSalary = {
  Skill.FLUTTER: 5000,
  Skill.DART: 3000,
  Skill.OTHER: 1000,
};

class Address {
  final Country country;
  final String city;
  final String zipCode;
  final String street;

  Address(
      {required this.country,
      required this.city,
      required this.zipCode,
      required this.street});

  @override
  String toString() {
    return "Address($country, $city, $zipCode, $street)";
  }
}

class Employee {
  late final String _name;
  late final Address _address;
  late double _baseSalary;
  late final Set<Skill> _skills; // Converted to Set to not have duplicates.
  late int _yearsOfExperience;

  Employee({
    required String name,
    required Address address,
    required int yearsOfExperience,
    required double baseSalary,
    required Iterable<Skill> skills,
  })  : this._name = name,
        this._address = address,
        this._baseSalary = baseSalary,
        this._skills = skills.toSet(),
        this._yearsOfExperience = yearsOfExperience;

  /// Mobile developers have Dart & Flutter as their default skills.
  Employee.mobileDeveloper({
    required String name,
    required double baseSalary,
    required Address address,
    required int yearsOfExperience,
    Iterable<Skill>? skills,
  }) {
    Set<Skill> defaultSkills = {Skill.DART, Skill.FLUTTER};

    // Add any provided skills other than the default.
    if (skills != null) defaultSkills.addAll(skills);

    this._name = name;
    this._baseSalary = baseSalary;
    this._skills = defaultSkills;
    this._address = address;
    this._yearsOfExperience = yearsOfExperience;
  }

  String get name => _name;
  double get baseSalary => _baseSalary;
  Set<Skill> get skills => _skills;
  Address get address => _address;
  int get yearsOfExperience => _yearsOfExperience;

  void printDetails() {
    print(
        'Employee($_name, $_address, Base Salary: \$${_baseSalary}, Skills($_skills), $_yearsOfExperience)');
  }

  double getSalary() {
    double salary = this._baseSalary;
    salary += 2000 * _yearsOfExperience;
    // Add for every skills, default to `Other` if not found. (the ! should never trigger dont worry).
    this._skills.forEach((skill) => salary += skillSalary[skill] ?? skillSalary[Skill.OTHER]!);
    return salary;
  }
}

void main() {
  Address address1 = Address(
      country: Country.CAMBODIA,
      city: "Phnom Penh",
      zipCode: "12102",
      street: "2004");
  Employee emp1 = Employee(
      name: 'Manut',
      address: address1,
      yearsOfExperience: 0,
      baseSalary: 4000,
      skills: []);
  emp1.printDetails();
  print("\$${emp1.getSalary()}");

  Address address2 = Address(
      country: Country.FRANCE,
      city: "Paris",
      zipCode: "70123",
      street: "Basin Street");
  var emp2 = Employee.mobileDeveloper(
      name: 'Ronan',
      address: address2,
      yearsOfExperience: 10,
      baseSalary: 6000);
  emp2.printDetails();
  print("\$${emp2.getSalary()}");
}
