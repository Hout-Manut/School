#include <iostream>
using namespace std;

struct Person
{
    int data;
    Person *next = NULL;
};

struct Stack
{
    int n;
    Person *top = NULL;
};

Stack *createEmptyStack()
{
    Stack *s = new Stack;
    s->n = 0;
    return s;
}

void push(int data, Stack *s)
{
    Person *p = new Person;
    p->data = data;
    p->next = s->top;
    s->top = p;
    s->n++;
}

void pop(Stack *s)
{
    if (s->n == 0)
    {
        cout << "Stack is empty" << endl;
        return;
    }
    Person *p;
    p = s->top;
    s->top = p->next;
    s->n--;
    delete p;
    return;
}

void display(Stack *s)
{
    Person *p;
    p = s->top;
    cout << p->data << endl;
    while (p != NULL)
    {
        cout << p->data << endl;
        p = p->next;
    }
    cout << endl;
    return;
}

main()
{
    Stack *s1 = createEmptyStack();
    push(1, s1);
    push(9, s1);
    // cout << s1->top->next->next->data << endl;
    push(-2, s1);
    push(7, s1);
    push(3, s1);

    display(s1);

    // pop(s1);
    // display(s1);
}