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

void loadingAnim()
{
    cout << "\r~~-------------";
    cafe::sleep(0, 200);
    cout << "\r~~~~~~---------";
    cafe::sleep(0, 100);
    cout << "\r~~~~~~~~~~~~---";
    cafe::sleep(0, 400);
    cout << "\r~~~~~~~~~~~~~--";
    cafe::sleep(0, 900);
    cout << "\r~~~~~~~~~~~~~~-";
    cafe::sleep(0, 300);
    cout << "\r~~~~~~~~~~~~~~~\n";
    cout << "Item added to cart.";
}

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
    int selected_id;
    string new_name;
    float new_s, new_m, new_l;
    bool isUsing = true;
    do
    {
        string name;
        int menuSize = cafeList.getMenuAmount();
        cafe::clearScreen();
        cout << endl;
        cafe::printMiddle("==== Admin Menu ====");
        cout << endl;
        cout << "1. Add new menu item\n"
             << "2. Edit menu item\n"
             << "3. Remove menu item\n"
             << "4. View menu\n"
             << "5. Back\n"
             << "Choose an option: ";
        opt = cafe::getInt(5);
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
            if (name == "0")
                break;
            cout << "Enter the price for the small size: ";
            priceSmall = cafe::getFloat();
            cout << "Enter the price for the medium size: ";
            priceMedium = cafe::getFloat();
            cout << "Enter the price for the large size: ";
            priceLarge = cafe::getFloat();
            cout << "Adding new menu item" << endl;
            cafeList.addMenuItem(name, priceSmall, priceMedium, priceLarge);
            loadingAnim();
            cafeList.saveData("data/menu.txt");
            cafe::clearScreen();
            cout << endl;
            cafe::printMiddle("Menu item added successfully!");
            cout << endl;
            cafe::sleep(1);
            cout << "Press Enter to continue...";
            cafe::awaitEnter();
            break;
        case 2:
            cafe::clearScreen();

            cafe::printMiddle("Edit menu item");
            cout << endl;
            cafeList.showMenuItem('-');
            cout << endl;
            cout << "Enter the id of the item to edit: ";
            selected_id = cafe::getInt(menuSize);
            cout << "Enter the new name of the item: ";
            cin >> new_name;
            cin.ignore();
            cout << "Enter the new price for the small size: ";
            new_s = cafe::getFloat();
            cout << "Enter the new price for the medium size: ";
            new_m = cafe::getFloat();
            cout << "Enter the new price for the large size: ";
            new_l = cafe::getFloat();
            cout << "Editing menu item" << endl;
            cafeList.updateMenuItem(selected_id, new_name, new_s, new_m, new_l);
            loadingAnim();
            cafeList.saveData("data/menu.txt");
            cafe::clearScreen();
            cout << endl;
            cafe::printMiddle("Menu item edited successfully!");
            cout << endl;
            cafe::sleep(1);
            cout << "Press Enter to continue...";
            cafe::awaitEnter();
            break;
        case 3:
            cafe::clearScreen();
            int remove_id;

            cafe::printMiddle("Remove menu item");
            cout << endl;
            cafeList.showMenuItem('-');
            cout << endl;
            cout << "Enter the id of the item to remove: ";
            remove_id = cafe::getInt(menuSize);
            cout << "Removing menu item" << endl;
            cafeList.removeMenuItem(remove_id);
            loadingAnim();
            cafeList.saveData("data/menu.txt");
            cafe::clearScreen();
            cout << endl;
            cafe::printMiddle("Menu item removed successfully!");
            cout << endl;
            cafe::sleep(1);
            cout << "Press Enter to continue...";
            cafe::awaitEnter();
            break;
        case 4:
            cafe::clearScreen();
            cout << endl;
            cafe::printMiddle("Menu");
            cout << endl;
            cafeList.showMenuItem('-');
            cout << endl;
            cin.ignore();
            cafe::sleep(1);
            cout << "Press Enter to continue...";
            cafe::awaitEnter();
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
    string sizeStr;
    float price;
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
        if (pick == "0")
            return;
        itemPtr = cafeList.getMenuItem(pick);

        if (itemPtr == nullptr)
        {
            cout << "\nItem not found!" << endl;
            cafe::sleep(1);
            cout << "Press Enter to continue...";
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
        cout << endl;
        cout << "\n1. Small\n"
             << "2. Medium\n"
             << "3. Large\n"
             << "Choose a size: ";
        size = cafe::getInt(3);
        switch (size)
        {
        case 0:
            break;
        case 1:
            sizeStr = "Small";
            price = itemPtr->small;
            break;
        case 2:
            sizeStr = "Medium";
            price = itemPtr->medium;
            break;
        case 3:
            sizeStr = "Large";
            price = itemPtr->large;
            break;
        }
        cout << "\rEnter quantity: ";
        quantity = cafe::getInt();
        cafe::clearScreen();
        cout << endl;
        cout << "Processing" << endl;
        cafeList.addToCart(itemPtr->name, sizeStr, price, quantity);
        loadingAnim();
        cafe::sleep(1);

        cafe::clearScreen();
        cout << endl;
        return;
    }
}

void cart()
{
    float total;
    int opt;
    int cartSize;
    int selected_id;
    char yn;
    string str;
    while (true)
    {
        total = cafeList.getTotalPrice();
        cartSize = cafeList.getCartAmount();
        cafe::clearScreen();
        cout << endl;
        cafe::printMiddle("==== Your Cart ====");
        cout << endl;
        if (cartSize == 0)
        {
            cout << "Your cart is empty!" << endl;
            cafe::sleep(2);
            return;
        }
        cout << "ID  Item name            Size     Qty   Price\n\n";
        cafeList.showCart();
        cout << "Total:                                  $" << total << endl;
        cout << "\n"
             << "1. Remove an item\n"
             << "2. Clear cart\n"
             << "0. Go back\n"
             << "Choose an option: ";
        cin >> opt;
        switch (opt)
        {
        case 0:
            return;
        case 1:
            cafe::clearScreen();

            cafe::printMiddle("==== Remove an item from cart ====");
            cout << endl;
            cout << "ID  Item name            Size     Qty   Price\n\n";
            cafeList.showCart();
            cout << "\nEnter the ID of the cart item: ";
            selected_id = cafe::getInt(cartSize);
            if (selected_id == 0)
                continue;
            cout << "Removing item from cart" << endl;
            cafeList.removeCartItem(selected_id);
            loadingAnim();
            cafe::clearScreen();
            cout << endl;
            cafe::printMiddle("Cart item removed successfully!");
            cout << endl;
            cafe::sleep(1);
            cout << "Press Enter to continue...";
            cin.ignore();
            cafe::awaitEnter();
            continue;
        case 2:
            cafe::clearScreen();
            cout << endl;
            if (cartSize == 1)
                str = "You are about to remove " + to_string(cartSize) + " item from cart.";
            else
                str = "You are about to remove " + to_string(cartSize) + " items from cart.";
            cafe::printMiddle(str);
            cout << "\n\tAre you sure? (y/n): ";
            cin >> yn;
            if (yn == 'y')
            {
                cout << "Clearing cart";
                cafeList.clearCart();
                loadingAnim();
                cout << "Cart cleared!";
                return;
            }
            else if (yn == 'n')
            {
                cout << "Reverting changes";
                cafe::sleep(1);
                return;
            }
            else
            {
                cout << "Input not recognized. Proceeding as 'No'\n";
            cafe:
                cafe::sleep(1);
                return;
            }
        default:
            break;
        }
    }
}

bool checkout()
{
    int opt;
    float total = cafeList.getTotalPrice();
    cafe::clearScreen();
    cout << endl;
    cafe::printMiddle("==== Checkout ====");
    cout << endl;
    cout << "ID  Item name            Size     Qty   Price\n\n";
    cafeList.showCart();
    cout << "Total:                                  $" << total << endl;
    cout << "Please pay with your prefered payment method. Then press Enter to continue.\n";
    cin.ignore();
    cafe::awaitEnter();
    cout << "Processing\n";
    cafeList.checkout(user);
    loadingAnim();
    cafe::clearScreen();
    cout << endl;
    cafe::printMiddle("==== Receipt ====");
    cout << endl;
    cafeList.showReciept(user);
    cafeList.clearCart();
    cafe::sleep(2);
    cout << "\n1. Go back\n"
         << "0. Exit the program\n"
         << "Choose an option: ";
    cin >> opt;
    switch (opt)
    {
    case 1:
        return true;
    case 0:
        cafe::clearScreen();
        cafe::printMiddle("Thank you for using the Cafe Management Program!");
        cout << endl;
        cafe::sleep(2);
        exit(0);
    default:
        return true;
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
        cin.ignore();
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
                 << "2. View cart (" + to_string(cartAmount) + cartStr + ")\n"
                 << "3. Checkout\n"
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
        case 2:
            cart();
            break;
        case 3:
            isUsing = checkout();
            break;
        default:
            isUsing = false;
            break;
        }
    } while (isUsing);
    return false;
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