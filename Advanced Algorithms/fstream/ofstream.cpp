#include <iostream>
#include <fstream>
using namespace std;

main() {
    fstream f;
    string id, name, gender;
    f.open("data.txt", ios::app);

    cout << "Add student information." << endl;
    cout << "Enter ID: ";
    cin >> id;
    cout << "Enter Name: ";
    cin >> name;
    cout << "Enter Gender: ";
    cin >> gender;

    f <<  "\n" << id << "\t" << name << "\t" << gender;

    f.close();
}