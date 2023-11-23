#include "cafeold.h"
#include <iostream>
#include <iomanip>
#include <fstream>
#include <string>
#include <thread>
#include <chrono>
#include <conio.h>
#include <algorithm>
using namespace std;

void userLogin();

int baseTextOffset = 60;
bool isAdmin = false;
string customerName = "Guest";

// Random Functions

void clearscreen()
{
    cout << "\x1B[2J\x1B[H"; // ANSI escape code to clear the screen
}

void sleep(int seconds)
{
    this_thread::sleep_for(chrono::seconds(seconds));
}

void awaitEnter()
{
    while (_getch() != 13)
    {
        // wait for Enter key
        // do nothing
    }
}

int getInt(int max) // a function to only get int as inputs
{
    int n;
    while (!(cin >> n) || n > max)
    {
        cout << "Invalid input. Try again: ";
        cin.clear();
        cin.ignore(1000, '\n');
    }
    return n;
}

void printMiddle(string str)
{
    cout << left << setw(baseTextOffset - (str.length() / 2)) << "" << str;
}

string encrypt(string str)
{
    reverse(str.begin(), str.end());
    return str;
}

string getPassword() // Creds to limhao's team.
{
    string password;
    char ch;

    // Read characters until Enter is pressed
    while ((ch = _getch()) != 13) // 13 is the ASCII code for Enter
    {
        if (ch == 8) // 8 is the ASCII code for Backspace
        {
            if (!password.empty())
            {
                cout << "\b \b"; // Erase the last asterisk
                password.pop_back();
            }
        }
        else
        {
            cout << '*';
            password += ch;
        }
    }

    return password;
}

string getStringMiddle(string question)
{
    string str;
    string string;
    char ch;
    printMiddle(question);
    while ((ch = _getch()) != 13)
    {
        if (ch == 8)
        {
            if (!str.empty())
            {
                str.pop_back();
            }
        }
        else if (str.length() < 16)
        {
            str += ch;
        }
        cout << "\t\r" << flush;
        string = question + str;
        cout << left << setw(100) << "";
        cout << "\t\r" << flush;
        printMiddle(string);
    }
    return str;
}

// End of Random Functions

class CafeList
{
private:
    cafe::MenuItemNode *menuHead;
    cafe::OrderNode *orderHead;

public:
    CafeList()
    {
        menuHead = NULL;
        orderHead = NULL;
    }

    ~CafeList()
    {
        cafe::MenuItemNode *currentMenu = menuHead;
        while (currentMenu != NULL)
        {
            cafe::MenuItemNode *temp = currentMenu;
            currentMenu = currentMenu->next;
            delete temp;
        }

        cafe::OrderNode *currentOrder = orderHead;
        while (currentOrder != NULL)
        {
            cafe::OrderNode *temp = currentOrder;
            currentOrder = currentOrder->next;
            delete temp;
        }
    }

    void addMenuItem(cafe::MenuItem &item)
    {
        cafe::MenuItemNode *newNode = new cafe::MenuItemNode;
        newNode->data = item;
        newNode->next = NULL;

        if (menuHead == NULL)
        {
            menuHead = newNode;
        }
        else
        {
            cafe::MenuItemNode *current = menuHead;
            while (current->next != NULL)
            {
                current = current->next;
            }
            current->next = newNode;
        }
    }

    void removeMenuItem(string name)
    {
        cafe::MenuItemNode *current = menuHead;
        cafe::MenuItemNode *previous = NULL;

        while (current != NULL)
        {
            if (current->data.name == name)
            {
                if (previous == NULL)
                {
                    menuHead = current->next;
                }
                else
                {
                    previous->next = current->next;
                }
                delete current;
                return;
            }
            previous = current;
            current = current->next;
        }
    }

    void showMenu()
    {
        cafe::MenuItemNode *current = menuHead;
        int i = 1;

        while (current != NULL)
        {
            cout << i << ". " << current->data.name << endl;
            cout << "   Small: $" << current->data.priceSmall << endl;
            cout << "   Medium: $" << current->data.priceMedium << endl;
            cout << "   Large: $" << current->data.priceLarge << endl;
            cout << "   Quantity: " << current->data.quantity << endl;
            cout << endl;

            current = current->next;
            i++;
        }
    }

    void addOrder(cafe::Order &order)
    {
        cafe::OrderNode *newNode = new cafe::OrderNode;
        newNode->data = order;
        newNode->next = NULL;

        if (orderHead == NULL)
        {
            orderHead = newNode;
        }
        else
        {
            cafe::OrderNode *current = orderHead;
            while (current->next != NULL)
            {
                current = current->next;
            }
            current->next = newNode;
        }
    }
};

CafeList list;

void cafe::Cafe::loadMenuItem()
{
    cafe::MenuItem item;
    fstream menuFile;
    string name;

    menuFile.open("data/menu.txt", ios::in);
    if (menuFile.is_open())
    {
        while (menuFile >> name)
        {
            menuFile >> item.priceSmall >> item.priceMedium >> item.priceLarge >> item.quantity;
            item.name = name;
            list.addMenuItem(item);
        }
        menuFile.close();
    }
    else
    {
        cout << "Error opening menu file." << endl;
    }
}

void login()
{
    fstream file;
    string attemptText;
    string username, password;
    string inputUsername, inputPassword;
    int count = 0;

    file.open("data/secret.txt", ios::in);
    file >> username >> password;
    while (count < 3)
    {
        clearscreen();
        cout << "\n"
             << endl;
        printMiddle("Administrator Login");
        cout << endl;
        switch (count)
        {
        case 0:
            break;
        case 1:
            cout << "Please enter your username and password again. 2 attempts remaining." << endl;
            break;
        case 2:
            cout << "Please enter your username and password again. 1 attempt remaining." << endl;
            break;
        default:
            break;
        }

        cout << "Username: ";
        cin >> inputUsername;
        cout << "Password: ";
        inputPassword = getPassword();
        inputPassword = encrypt(inputPassword);
        cout << endl;
        if (inputUsername == username && inputPassword == password)
        {
            cout << "Login successful!" << endl;
            isAdmin = true;
            sleep(1);
            return;
        }
        else
        {
            count++;
            attemptText = "attempts";
            if (count == 1)
            {
                attemptText = "attempt";
            }

            cout << "Invalid username or password. (" << count << " " << attemptText << ")" << endl;
            sleep(1);
            continue;
        }
    }
    cout << "Too many attempts. Going back to menu screen as Guest.";
    sleep(1);
    userLogin();
    return;
}

void userLogin()
{
    int opt;
    string name;
    clearscreen();
    cout << "\n"
         << endl;
    printMiddle("Welcome to Cafe Management System.");
    cout << endl;
    name = getStringMiddle("Please state your name: ");
    customerName = name;
    cout << endl;
    clearscreen();
    printMiddle("Welcome to Cafe Management System, " + customerName + ".");
    sleep(1);
}

void adminMenu()
{
    int opt;
    clearscreen();
    cout << "\n"
         << endl;
    printMiddle("Welcome to Cafe Management System.");
    sleep(1);
    cout << "1. Add a product. \n"
         << "2. View a product. \n"
         << "3. Update a product. \n"
         << "4. Delete a product. \n"
         << "5. Exit. \n"
         << "Enter your choice: ";
    opt = getInt(5);
    switch (opt)
    {
    case 1:
        break;
    case 2:
        break;
    case 3:
        break;
    case 4:
        break;
    case 5:
        break;
    default:
        break;
    }
}

void customerMenu()
{
    int opt;
    clearscreen();
    cout << "\n"
         << endl;
    printMiddle("Welcome to Cafe Management System.");
    cout << endl;
    // if
    cout << "1. View a product. \n"
         << "2. Exit. \n"
         << "Enter your choice: ";
}

int main()
{
    // cafe::Cafe cafe;
    int opt;
    // clearscreen();
    cout << "\n"
         << endl;
    printMiddle("Welcome to Cafe Management System.");
    cout << endl;
    sleep(1);
    cout << "Who are you? \n"
         << "1. Admin \n"
         << "2. Customer \n"
         << "3. Exit \n"
         << "Enter your choice: ";
    opt = getInt(3);
    switch (opt)
    {
    case 1:
        login();
        break;
    case 2:
        userLogin();
        break;
    case 3:
        exit(0);
        break;
    default:
        break;
    }
    // cafe.loadMenuItem();
    // list.showMenu();
    if (isAdmin)
    {
        adminMenu();
    }
    else
    {
        customerMenu();
    }
}
