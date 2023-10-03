#include <iostream>
#include <iomanip>
#include <random>
using namespace std;

struct Node
{
    int num;
    Node *next;
};

void addNode(Node *&head, int value)
{
    Node *newNode = new Node;
    newNode->num = value;
    newNode->next = head;
    head = newNode;
}

int main()
{
    random_device rd;
    mt19937 generator(rd());
    uniform_int_distribution<int> dis(10, 1000);

    Node *head = nullptr;

    for (int i = 0; i < 100; ++i)
    {
        int randomNumber = dis(generator);
        addNode(head, randomNumber);
    }

    int count = 0;
    Node *current = head;
    while (current != nullptr)
    {
        cout << setw(4) << current->num;
        current = current->next;
        if (count % 10 == 9)
            cout << endl;
        count++;
    }

    while (head != nullptr)
    {
        Node *temp = head;
        head = head->next;
        delete temp;
    }

    return 0;
}
