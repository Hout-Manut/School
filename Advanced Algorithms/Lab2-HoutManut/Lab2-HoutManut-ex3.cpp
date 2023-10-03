#include <iostream>
#include <iomanip>
#include <windows.h>
using namespace std;

struct Student
{
    string id;
    int score;
    Student *next;
};

void awaitInput()
{
    Sleep(200);
    cout << "\nPress Enter to continue...";
    cin.get();
    cin.ignore(1000, '\n');
}

int getInt()
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

void createEmptyList(Student *&head)
{
    head = nullptr;
}

void addStudent(Student *&head)
{
    string id;
    int score;
    cout << "Enter student ID: ";
    cin >> id;
    cout << "Enter student score: ";
    score = getInt();

    Student *newStudent = new Student;
    newStudent->id = id;
    newStudent->score = score;
    newStudent->next = head;
    head = newStudent;

    Sleep(1000);
    cout << "\nStudent information added successfully\n"
         << "ID: " << id << ", Score: " << score << endl;
    awaitInput();
    system("cls");
}

void displayList(Student *head)
{
    Student *current = head;
    while (current != nullptr)
    {
        cout << "ID: " << current->id << ", Score: " << current->score << std::endl;
        current = current->next;
    }

    awaitInput();
}

void deleteFirstStudent(Student *&head)
{
    if (head != nullptr)
    {
        Student *temp = head;
        head = head->next;
        delete temp;
    }

    awaitInput();
}

int main()
{
    Student *head = nullptr;
home:
    int option;
    cout << "List of Students \n"
         << "1. Add student informations.\n"
         << "2. Display the student list.\n"
         << "3. Delete the first item.\n"
         << "Choose an option: ";
    option = getInt();
    system("cls");
    switch (option)
    {
    case 1:
        addStudent(head);
        goto home;

    case 2:
        displayList(head);
        goto home;

    case 3:
        deleteFirstStudent(head);
        goto home;

    default:
        break;
    }

    while (head != nullptr)
    {
        Student *temp = head;
        head = head->next;
        delete temp;
    }
}