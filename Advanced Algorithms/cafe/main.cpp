#include <iostream>
#include <fstream>
#include <string>
#include <iomanip>
#include "cafe.h"

using namespace std;

bool isAdmin = false;
bool isUser = false;
string user = "Guest";
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
            if (attempts == 2)
                str = "1 attempt remaining)";
            else
                str = to_string(3 - attempts) + " attempts remaining)";
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
    cout << "Enter your name: ";
    cin >> name;
    cout << "Hello " << name << "!" << endl;
    cafe::sleep(2);
    user = name;
    isUser = true;
    return;
}

bool adminMenu()
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
             << "5. Go to user menu\n"
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
            cafe::sleep(4);
            break;
        case 5:
            return true;
        }
    } while (isUsing);
    return true;
}

void order()
{
    string pick;
    int size;
    int quantity;
    int opt;
    bool isUsing = true;
    string str;
    cafe::MenuItem *itemPtr;
    while (isUsing)
    {
        cafe::clearScreen();
        cout << endl;
        cafe::printMiddle("==== Order ====");
        cout << endl;
        cafeList.showMenuItem('-');
        cout << endl;
        cout << "Choose an item (id or name): ";
        cin >> pick;
        cin.ignore();
        itemPtr = cafeList.getMenuItem(pick);

        if (itemPtr == nullptr)
        {
            cout << "\nItem not found!" << endl;
            cafe::sleep(1);
            cout << "Press any Enter to continue...";
            cafe::awaitEnter();
            continue;
        }
        cafe::clearScreen();
        cout << endl;
        cafe::printMiddle("==== Item Found ====");
        cout << endl;
        cout << left << setfill(' ') << setw(4) << "ID"
             << setw(21) << "Product Name"
             << setw(9) << "Small"
             << setw(9) << "Medium"
             << setw(8) << "Large Price" << endl;
        cout << left << setfill(' ') << setw(3) << itemPtr->id << " "
             << setw(20) << itemPtr->name << " "
             << "$" << fixed << setprecision(2) << setw(7) << itemPtr->small << " "
             << "$" << fixed << setprecision(2) << setw(7) << itemPtr->medium << " "
             << "$" << fixed << setprecision(2) << setw(7) << itemPtr->large << endl;

        std::cout << std::endl;

        cout << "\n1. Small\n"
             << "2. Medium\n"
             << "3. Large\n"
             << "Choose a size: ";
        size = cafe::getInt(3);
        cout << "\nEnter quantity: ";
        quantity = cafe::getInt();
        cafe::clearScreen();
        cout << endl;
        cout << "Processing" << endl;
        cout << "\r~~-------------";
        cafe::sleep(0, 200);
        cout << "\r~~~~~~---------";
        cafeList.addToCart(itemPtr, size, quantity);
        cafe::sleep(0, 100);
        cout << "\r~~~~~~~~~~~~---";
        cafe::sleep(0, 400);
        cout << "\r~~~~~~~~~~~~~--";
        cafe::sleep(0, 900);
        cout << "\r~~~~~~~~~~~~~~-";
        cafe::sleep(0, 300);
        cout << "\r~~~~~~~~~~~~~~~\n";
        cout << "Item added to cart.";
        cafe::sleep(1);

        cafe::clearScreen();
        cout << endl;
        cafe::printMiddle("==== Order ====");
        cout << endl;
        cout << std::left << std::setfill(' ') << std::setw(4) << "ID"
             << std::left << std::setw(21) << "Product Name" 
             << std::setw(9) << "Size"
             << std::setw(9) << "Price"
             << std::setw(8) << "Quatity" << "\n";
        cafeList.showCart();
        cout << endl;
        cout << "1. Add another item\n"
             << "0. Go Back\n"
             << "Choose an option: ";
             
        opt = cafe::getInt(1);
        cafe::clearScreen();
        switch (opt)
        {
        case 1:
            break;
        case 0:
            isUsing = false;
            break;
        }
    }
}

bool userMenu()
{
    int opt;
    bool isUsing = true;
    int cartAmount;
    string cartStr;
    do
    {
        cafe::clearScreen();
        cartAmount = cafeList.getCartAmount();
        cafe::printMiddle("==== Welcome to the Cafe Shop ====");
        cout << endl;
        if (cartAmount == 0)
        {
            cout << "1. Order a drink\n"
                 << "0. Go back\n"
                 << "Choose an option: ";
            opt = cafe::getInt(2);
        }
        else
        {
            if (cartAmount == 1)
                cartStr = " item";
            else
                cartStr = " items";
            cout << "1. Order a drink\n"
                 << "2. View cart (" + to_string(cartAmount) + cartStr + "\n"
                 << "3. Remove item from cart\n"
                 << "4. Clear cart\n"
                 << "0. Go back\n"
                 << "Choose an option: ";
            opt = cafe::getInt(5);
        }
        cafe::clearScreen();
        switch (opt)
        {
        case 1:
            order();
            break;
        default:
            isUsing = false;
            break;
        }
    } while (isUsing);
    return true;
}

int main()
{
    cafeList.loadData("data/menu.txt");
    int opt;
    int opt2;
    bool isUsing = true;

    // cafe::clearScreen();
    cafe::printMiddle("==== Welcome to the Cafe Management Program ====");
    cout << endl;
    cout << "Who are you?\n"
         << "1. Admin\n"
         << "2. Customer\n"
         << "0. Exit\n"
         << "Choose an option: ";
    opt = cafe::getInt(2);
    cafe::clearScreen();
    while (isUsing)
    {
        switch (opt)
        {
        case 1:
            if (!isAdmin)
                adminLogin();
            isUsing = adminMenu();
            isAdmin = false;
            break;
        case 2:
            if (!isUser)
                userLogin();
            else
            {
                cafe::clearScreen();
                cout << endl;
            }
            isUsing = userMenu();
            break;
        case 0:
            isUsing = false;
            break;
        }
        if (isUsing)
        {
            cafe::clearScreen();
            cout << endl;
            cafe::printMiddle("==== Cafe Management Program ====");
            cout << endl;
            if (isUser)
            {
                cout << "1. Go to Admin menu\n"
                     << "2. Go to User menu\n"
                     << "3. Change your name\n"
                     << "0. Exit\n"
                     << "Choose an option: ";
                opt2 = cafe::getInt(3);
            }
            else
            {
                cout << "1. Go to Admin menu\n"
                     << "2. Go to User menu\n"
                     << "0. Exit\n"
                     << "Choose an option: ";
                opt2 = cafe::getInt(2);
            }
            switch (opt2)
            {
            case 1:
                opt = 1;
                break;
            case 2:
                opt = 2;
                break;
            case 3:
                userLogin();
                break;
            case 0:
                isUsing = false;
                break;
            }
        }
    }
    cafe::clearScreen();
    cafe::printMiddle("Thank you for using the Cafe Management Program!");
    cout << endl;
    cafe::sleep(2);
    return 0;
}