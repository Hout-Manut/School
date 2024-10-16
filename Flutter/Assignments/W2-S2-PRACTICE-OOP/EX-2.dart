class BankAccount {
  final int _id;
  final String username;
  double _balance;

  BankAccount({
    required int id,
    required this.username,
  })  : _id = id,
        _balance = 0;

  double get balance => _balance;
  int get id => _id;

  double withdraw(double amount) {
    if (amount > _balance) throw Error;
    _balance -= amount;
    return amount;
  }

  void credit(double amount) => _balance += amount;
}

class Bank {
  final String name;
  final List<BankAccount> users = [];

  Bank({required this.name});

  BankAccount createAccount({required int id, required String username}) {
    users.forEach((acc) {
      if (acc.id == id) throw Error;
    });

    BankAccount acc = BankAccount(id: id, username: username);
    users.add(acc);

    return acc;
  }
}

void main() {
  Bank myBank = Bank(name: "CADT Bank");
  BankAccount ronanAccount = myBank.createAccount(id: 100, username: 'Ronan');

  print(ronanAccount.balance); // Balance: $0
  ronanAccount.credit(100);
  print(ronanAccount.balance); // Balance: $100
  ronanAccount.withdraw(50);
  print(ronanAccount.balance); // Balance: $50

  try {
    ronanAccount.withdraw(75); // This will throw an exception
  } catch (e) {
    print(e); // Output: Insufficient balance for withdrawal!
  }

  try {
    myBank.createAccount(
        id: 100, username: 'Honlgy'); // This will throw an exception
  } catch (e) {
    print(e); // Output: Account with ID 100 already exists!
  }
}
