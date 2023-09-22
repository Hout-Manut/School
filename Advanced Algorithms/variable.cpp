#include <iostream>
#include <windows.h>
using namespace std;

int main()
{
    int age = 19;
    float price = 5.99;
    double bigPrice = 9.99;
    char firstLetter = 'A';
    bool isTrue = true;

    system("cls");
    cout << age << "\n"
         << "$" << price << "\n"
         << "$" << bigPrice << "\n"
         << firstLetter << "\n"
         << isTrue << endl;
}