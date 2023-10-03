#include <iostream>
#include <iomanip>
#include <random>
using namespace std;

int main() {
    random_device rd;
    mt19937 gen(rd());
    uniform_int_distribution<int> dis(10, 1000);

    int a[100];
    for (int i = 0; i < 100; i++) {
        a[i] = dis(gen);
        cout << setw(4) << a[i];
        if (i % 10 == 9)
            cout << endl;
    }
}