#include <iostream>

using namespace std;

int getOddInt()
{
    while (true)
    {
        int n;
        cin >> n;
        if (n % 2 != 0)
        {
            return n;
        }
        else
        {
            cout << "Please enter an odd number: ";
        }
    }
}

int main()
{
    int x;
    cout << "Enter x: ";
    x = getOddInt();

    for (int i = 0; i < (x - 1) / 2; i++)
    {
        for (int j = 0; j < x; j++)
        {
            if (j == i || j == x - 1 - i || j == (x - 1) / 2)
            {
                cout << "*";
            }
            else
            {
                cout << " ";
            }
        }
        cout << endl;
    }
    for (int i = 0; i < x; i++)
    {
        cout << "*";
    }
    cout << endl;
    for (int i = (x - 3) / 2; i >= 0; i--)
    {
        for (int j = 0; j < x; j++)
        {
            if (j == i || j == x - 1 - i || j == (x - 1) / 2)
            {
                cout << "*";
            }
            else
            {
                cout << " ";
            }
        }
        cout << endl;
    }
}
