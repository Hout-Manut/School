#include <iostream>
#include <fstream>
#include <iomanip>
using namespace std;

main()
{
    fstream f;
    string id, name, gender;

    f.open("data.txt", ios::in);
    f >> id >> name >> gender;

    cout << left << setw(5) << id << setw(10) << name << gender << endl;

    while (!f.eof())
    {
        f >> id >> name >> gender;
        cout << left << setw(5) << id << setw(10) << name << gender << endl;
    }

    f.close();
}