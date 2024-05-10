#include <iostream>
#include <cstdlib>
#include <ctime>

using namespace std;

int main()
{
    const int n = 10;
    srand(time(nullptr));

    int matrix[n][n];
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            matrix[i][j] = rand() % 100;
            cout << matrix[i][j] << " ";
        }
        cout << endl;
    }

    // A
    int highestA = 0;

    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            if (i > j)
                continue;
            if (matrix[i][j] > highestA)
                highestA = matrix[i][j];
        }
    }

    // B
    int highestB = 0;
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            if (j > i)
                continue;
            if (matrix[i][j] > highestB)
                highestB = matrix[i][j];
        }
    }

    // C
    int highestC = 0;
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            if (i > j || j > n - i)
                continue;
            if (matrix[i][j] > highestC)
                highestC = matrix[i][j];
        }
    }

    // D
    int highestD = 0;
    for (int i = 0; i < n; i++)
    {
        for (int j = 0; j < n; j++)
        {
            if (j > i || j - n > i)
                continue;
            if (matrix[i][j] > highestD)
                highestD = matrix[i][j];
        }
    }

    // E
    int highestE = highestC;
    if (highestE < highestD)
        highestE = highestD;

    cout << "\n\n";
    cout << "A: " << highestA << endl;
    cout << "B: " << highestB << endl;
    cout << "C: " << highestC << endl;
    cout << "D: " << highestD << endl;
    cout << "E: " << highestE << endl;
    return 0;
}
