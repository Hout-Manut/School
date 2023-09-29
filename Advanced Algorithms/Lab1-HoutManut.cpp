#include <iostream>
#include <iomanip>
#include <cmath>
#include <windows.h>
#include <string>
using namespace std;

struct Person // 6
{
    string name, zodiac;
    int age;
};

void awaitInput() // a function to wait for the user
{
    Sleep(2000);
    cout << "\nPress Enter to continue...";
    cin.get();
    cin.ignore(1000, '\n');
}

int getInt() // a function to only get int as inputs
{
    int n;
    while (!(cin >> n))
    {
        cout << "Invalid input. Try again: ";
        cin.clear();
        cin.ignore(1000, '\n');
    }
    return n;
}

void calcQuadratic() // 1
{
    int a, b, c;
    cout << "Calculate 'ax^2 + bx + c = 0'\n\n"
         << "Enter a, b, c: ";
    while (!(cin >> a >> b >> c))
    {
        cout << "Invalid input. Try again.\n";
        cin.clear();
        cin.ignore(1000, '\n');
    }

    int delta = b * b - 4 * a * c;
    float x1, x2;
    system("cls");
    cout << a << "x^2 + " << b << "x + " << c << " = 0\n\n"
         << "Determinant = " << delta << "\n\n"
         << "Result:\n";
    if (delta > 0)
    {
        x1 = (-b + sqrt(delta)) / (2 * a);
        x2 = (-b - sqrt(delta)) / (2 * a);
        cout << "x1: " << x1 << "\nx2: " << x2 << endl;
    }
    else if (delta < 0)
    {
        x1 = -b / (2 * a);
        x2 = sqrt(-delta) / (2 * a);
        cout << "x1: " << x1 << "+" << x2 << "i"
             << "\nx2: " << x1 << "-" << x2 << "i" << endl;
    }
    else
    {
        x1 = -b / (2 * a);
        cout << "x1 = x2: " << x1 << endl;
    }

    awaitInput();
}

void printNum() // 2
{
    int count = 0;
    for (int i = 1; i <= 1000; i++)
    {
        if (i % 100 == 0 && i <= 500)
            continue;
        else
            cout << setw(5) << i;
        count++;
        if (count % 20 == 0)
            cout << endl;
    }

    awaitInput();
}

void inputNum() // 3
{
    int num, total = 0;
    bool first = true;
    cout << "Enter a number. (-1 to end.): ";
    while (true)
    {
        if (first == false)
            cout << "Enter another number: ";

        num = getInt();
        if (num == -1)
            break;
        total += num;
        first = false;
    }
    cout << "Program ended.\n"
         << "Total: " << total << endl;

    awaitInput();
}

void calcDiv(int n) // 4
{
    float result;
    for (int i = 1; i <= n; i++)
    {
        result = 1.0 / i;
        cout << "1/" << i << " = " << result << "\n";
    }

    awaitInput();
}

int sumSuite(int n) // 5.a
{
    int total = 0;
    for (int i = 0; i <= n; i++)
        total += i;
    return total;
}

int sumDigit(int n) // 5.b
{
    int total = 0;
    while (n > 0)
    {
        total += n % 10;
        n /= 10;
    }
    return total;
}

void structTest() // 6
{
    Person person[20];
    cout << "Enter the information of 4 people.\n";
    cin.ignore(1000, '\n');

    for (int i = 0; i < 4; i++)
    {
        cout << "Enter the name of person " << i + 1 << ": ";
        getline(cin, person[i].name);
        cout << "Enter the age of person " << i + 1 << ": ";
        person[i].age = getInt();
        cin.ignore();
        cout << "Enter the zodiac sign of person " << i + 1 << ": ";
        getline(cin, person[i].zodiac);
        cout << endl;
    }

    int oldestAge = 0;
    cout << "Name\t\tAge\tZodiac\n"
         << "------------------------------" << endl;
    for (int i = 0; i < 4; i++)
    {
        cout << left << setw(16) << person[i].name
             << setw(8) << person[i].age
             << setw(16) << person[i].zodiac << endl;
        if (person[i].age > oldestAge)
            oldestAge = person[i].age;
    }
    cout << endl;

    int oldestCount = 0;
    Person oldest[20];
    for (int i = 0; i < 4; i++)
    {
        if (person[i].age == oldestAge)
        {
            oldest[oldestCount].name = person[i].name;
            oldest[oldestCount].zodiac = person[i].zodiac;
            oldestCount++;
        }
    }
    cout << "The oldest age is " << oldestAge
         << "\nName\t\tZodiac\n" 
         << "----------------------" << endl;
    for (int i = 0; i < oldestCount; i++)
    {
        cout << left << setw(16) << oldest[i].name
             << oldest[i].zodiac << endl;
    }

    awaitInput();
}

void pointerTest() // 7
{
    int x, y;
    cout << "Enter x: ";
    x = getInt();
    cout << "Enter y: ";
    y = getInt();

    int *p1 = &x;
    int *p2 = &y;

    cout << "\nAddress of x: " << p1 
         << "\nValue of x: " << *p1 
         << "\nAddress of y: " << p2 
         << "\nValue of y: " << *p2 
         << endl;

    awaitInput();
}

void exchangeNumber(int *n, int *m) // 8
{
    int buffer;
    buffer = *n;
    *n = *m;
    *m = buffer;
}

int main()
{
exit:
    int n = 0;
    system("cls");
    cout << "Choose an option.\n"
         << "1. Calculate the quadratic formula.\n"
         << "2. Print numbers from 1 to 1000.\n"
         << "3. Input numbers.\n"
         << "4. Calculate 1/n for n numbers.\n"
         << "5. Mathematical operations\n"
         << "6. Structure\n"
         << "7. Pointers\n"
         << "8. Exchange numbers\n"
         << endl;
    int option = getInt();
    system("cls");
    switch (option)
    {
    case 1:
        calcQuadratic();
        goto exit;

    case 2:
        printNum();
        goto exit;

    case 3:
        inputNum();
        goto exit;

    case 4:
        while (n <= 0)
        {
            cout << "Enter n: ";
            n = getInt();
            if (n <= 0)
                cout << "n must be greater than 0." << endl;
        }
        cout << "\nResult: " << endl;
        calcDiv(n);
        goto exit;

    case 5:
        int subOption;
        while (true)
        {
            cout << "Choose an operation.\n"
                 << "1. Sum of 1 to n.\n"
                 << "2. Sum of all digits of n.\n"
                 << "0. Exit."
                 << endl;
            subOption = getInt();
            cout << "Enter n: ";
            n = getInt();
            switch (subOption)
            {
            case 1:
                cout << "\nSum of 1 to " << n << " is " << sumSuite(n) << "." << endl;
                break;

            case 2:
                cout << "\nSum of all digits of " << n << " is " << sumDigit(n) << "." << endl;
                break;

            default:
                goto exit;
            }

            awaitInput();
            system("cls");
        }

    case 6:
        structTest();
        goto exit;

    case 7:
        pointerTest();
        goto exit;

    case 8:
        int x, y;
        cout << "Enter x: ";
        x = getInt();
        cout << "Enter y: ";
        y = getInt();
        cout << endl;

        cout << "Before exchange. x = " << x << ", y = " << y << endl;
        exchangeNumber(&x, &y);
        Sleep(1200);
        cout << "After exchange. x = " << x << ", y = " << y << endl;

        awaitInput();
        goto exit;

    default:
        system("cls");
        break;
    }
}