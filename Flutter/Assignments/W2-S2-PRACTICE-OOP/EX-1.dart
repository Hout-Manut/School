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
  late final List<Skill> _skills;
  late int _yearsOfExperience;

  Employee({
    required String name,
    required Address address,
    required int yearsOfExperience,
    required double baseSalary,
    required List<Skill> skills,
  })  : this._name = name,
        this._address = address,
        this._baseSalary = baseSalary,
        this._skills = skills,
        this._yearsOfExperience = yearsOfExperience;

  Employee.mobileDeveloper({
    required String name,
    required double baseSalary,
    required Address address,
    required int yearsOfExperience,
    List<Skill>? skills,
  }) {
    List<Skill> defaultSkills = [Skill.DART, Skill.FLUTTER];
    if (skills != null) {
      defaultSkills.addAll(skills);
    }

    this._name = name;
    this._baseSalary = baseSalary;
    this._skills = defaultSkills;
    this._address = address;
    this._yearsOfExperience = yearsOfExperience;
  }

  String get name => _name;
  double get baseSalary => _baseSalary;
  List<Skill> get skills => _skills;
  Address get address => _address;
  int get yearsOfExperience => _yearsOfExperience;

  void printDetails() {
    print('Employee($_name, $_address, Base Salary: \$${_baseSalary}, Skills($_skills), $_yearsOfExperience)');
  }

  double getSalary() {
    double salary = this._baseSalary;
    salary += 2000 * _yearsOfExperience;
    this._skills.forEach((skill) => salary += skillSalary[skill] ?? 1000);
    return salary;
  }
}

void main() {
  Address address1 = Address(country: Country.CAMBODIA, city: "Phnom Penh", zipCode: "12102", street: "2004");
  Employee emp1 = Employee(name: 'Manut', address: address1, yearsOfExperience: 0, baseSalary: 4000, skills: []);
  emp1.printDetails();
  print("\$${emp1.getSalary()}");

  Address address2 = Address(country: Country.FRANCE, city: "Paris", zipCode: "70123", street: "Basin Street");
  var emp2 = Employee.mobileDeveloper(name: 'Ronan', address: address2, yearsOfExperience: 10, baseSalary: 6000);
  emp2.printDetails();
  print("\$${emp2.getSalary()}");
}
