#include <iostream>
#include <fstream>
#include <string>
#include <iomanip>
#include "cafe.h"

using namespace std;

bool isAdmin = false;
cafe::CafeList cafeList;

void adminLogin()
{
    string username, password;
    int attempts = 0;
    std::string str;
    while (attempts < 3)
    {
        cafe::clearScreen();
        cout << endl;
        cafe::printMiddle("==== Admin Login ====");
        cout << endl;
        cout << "\tUsername: ";
        cin >> username;
        cin.ignore();
        cout << "\tPassword: ";
        password = cafe::getPassword();
        if (cafe::validateAdmin(username, password))
        {
            isAdmin = true;
            break;
        }
        else
        {
            if (attempts == 2) str = "1 attempt remaining)";
            else str = to_string(3 - attempts) + " attempts remaining)";
            cout << "\nInvalid username or password!, (" << str << endl;
            attempts++;
            cafe::sleep(1);
        }
    }
    if (isAdmin)
    {
        cafe::clearScreen();
        cout << endl;
        cafe::printMiddle("Login successful.");
        cafe::sleep(1);
        return;
    }
    else
    {
        cafe::clearScreen();
        cout << endl;
        cafe::printMiddle("Login failed, returning as a user.");
        cafe::sleep(2);
        return;
    }
}

void userLogin()
{
    string name;
    cafe::clearScreen();
    cout << endl;
    cafe::printMiddle("==== Welcome to the Cafe Management Program ====");
    cout << endl;
    while (true)
    {
    cout << "Enter your name: ";
    cin >> name;
    cout << "Hello " << name << "!" << endl;
    cafe::sleep(2);
    return;
    }
}

void adminMenu()
{
    int opt;
    bool isUsing = true;
    do
    {
        string name;
        cafe::clearScreen();
        cout << endl;
        cafe::printMiddle("==== Admin Menu ====");
        cout << endl;
        cout << "1. Add new menu item\n"
             << "2. Edit menu item\n"
             << "3. Remove menu item\n"
             << "4. View menu\n"
             << "0. Back\n"
             << "Choose an option: ";
        opt = cafe::getInt(4);
        cafe::clearScreen();
        switch (opt)
        {
            case 1:
                cafe::clearScreen();
                cout << endl;
                float priceSmall, priceMedium, priceLarge;
                cafe::printMiddle("Add new menu item");
                cout << endl;
                cout << "Enter the name of the item: ";
                cin >> name;
                cin.ignore();
                cout << "Enter the price for a small size: ";
                priceSmall = cafe::getFloat();
                cout << "Enter the price for a medium size: ";
                priceMedium = cafe::getFloat();
                cout << "Enter the price for a large size: ";
                priceLarge = cafe::getFloat();
                cout << "Adding new menu item";
                cafeList.addMenuItem(name, priceSmall, priceMedium, priceLarge);
                for (int i = 0; i < 3; i++) 
                {
                    cout << ".";
                    cafe::sleep(1);
                }
                cafeList.saveData("data/menu.txt");
                cafe::clearScreen();
                cout << endl;
                cafe::printMiddle("Menu item added successfully!");
                cout << endl;
                cafe::sleep(1);
                cout << "Press any Enter to continue...";
                cafe::awaitEnter();
                break;
            case 2:
                cafe::clearScreen();
                break;
            case 4:
                cafe::clearScreen();
                cout << endl;
                cafe::printMiddle("Menu");
                cout << endl;
                cafeList.showMenuItem('-');
                cout << endl;
                cout << "Press any Enter to continue...";
                cafe::awaitEnter();
                break;
        }
        isUsing = false;
    } while (isUsing);
}

int main()
{
    cafeList.loadData("data/menu.txt");
    int opt;
    bool isUsing = true;
    do
    {
        cafe::clearScreen();
        cafe::printMiddle("==== Welcome to the Cafe Management Program ====");
        cout << endl;
        cout << "Who are you?\n"
             << "1. Admin\n"
             << "2. Customer\n"
             << "0. Exit\n"
             << "Choose an option: ";
        opt = cafe::getInt(2);
        cafe::clearScreen();
        switch (opt)
        {
        case 1:
            adminLogin();
        }
        if (isAdmin)
        {
            adminMenu();
        }

        isUsing = false;
        cafe::clearScreen();
        cout << endl;
        cafe::printMiddle("Thank you for using the Cafe Management Program!");
    } while (isUsing);
}