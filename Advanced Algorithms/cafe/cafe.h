#ifndef CAFE_H
#define CAFE_H

#include <iostream>
#include <string>
#include <thread>
#include <chrono>
#include <curses.h>
#include <stdlib.h>
#include <iomanip>
#include <algorithm>
#include <fstream>
#if defined(_WIN32) || defined(_WIN64)
#include <conio.h> // For _getch() on Windows
#else
#include <termios.h>
#include <unistd.h>

// Function to set and reset the terminal attributes for Unix-like systems
void setTerminalMode(bool enableEcho)
{
    struct termios tty;
    tcgetattr(STDIN_FILENO, &tty);
    if (!enableEcho)
    {
        tty.c_lflag &= ~ECHO;
    }
    else
    {
        tty.c_lflag |= ECHO;
    }

    (void)tcsetattr(STDIN_FILENO, TCSANOW, &tty);
}
#endif

namespace cafe
{
    void clearScreen()
    {
        std::cout << "\x1B[2J\x1B[H"; // ANSI escape code to clear the screen
    }

    void sleep(int seconds)
    {
        std::this_thread::sleep_for(std::chrono::seconds(seconds));
    }

    void awaitEnter()
    {
        // while (_getch() != 13)
        // {
        //     // wait for Enter key
        //     // do nothing
        // }

        std::string str;
        std::cin >> str;
    }

    int getInt(int max) // a function to only get int as inputs
    {
        int n;
        while (!(std::cin >> n) || n > max)
        {
            std::cout << "Invalid input. Try again: ";
            std::cin.clear();
            std::cin.ignore(1000, '\n');
        }
        return n;
    }

    void printMiddle(std::string str, int baseTextOffset = 60)
    {
        std::cout << std::left << std::setw(baseTextOffset - (str.length() / 2)) << "" << str;
    }

    std::string encrypt(std::string str)
    {
        std::reverse(str.begin(), str.end());
        return str;
    }

    void clearLine()
    {
        std::cout << "\t\r" << std::flush;
        std::cout << std::left << std::setw(100) << "";
    }

    std::string getPassword()
    {
        std::string password;
        char ch;

#if defined(_WIN32) || defined(_WIN64)
        // Windows-specific code
        while ((ch = _getch()) != 13)
        {
            if (ch == 8)
            {
                if (!password.empty())
                {
                    std::cout << "\b \b";
                    password.pop_back();
                }
            }
            else
            {
                std::cout << '*';
                password += ch;
            }
        }
#else
        // Unix-like systems code
        setTerminalMode(false);

        while ((ch = getchar()) != '\n')
        {
            if (ch == 127)
            { // Backspace on Unix
                if (!password.empty())
                {
                    std::cout << "\b \b";
                    password.pop_back();
                }
            }
            else
            {
                std::cout << '*';
                password += ch;
            }
        }

        setTerminalMode(true);
#endif

        return password;
    }

    struct MenuItem
    {
        int id;
        std::string name;
        float small, medium, large;
        int quantity;
    };

    struct MenuItemNode
    {
        MenuItem data;
        MenuItemNode *next;
    };

    struct CartItem
    {
        int id, productId;
        std::string productName, size;
        float price;
    };

    struct CartItemNode
    {
        CartItem data;
        CartItemNode *next;
    };

    class CafeList
    {
    private:
        MenuItemNode *menuHead;
        int menuAmount;
        CartItemNode *cartHead;
        int cartAmount;

    public:
        CafeList()
        {
            menuHead = NULL;
            menuAmount = 0;
            cartHead == NULL;
            cartAmount = 0;
        }
        ~CafeList()
        {
            MenuItemNode *currentMenu = menuHead;
            while (currentMenu != NULL)
            {
                MenuItemNode *temp = currentMenu;
                currentMenu = currentMenu->next;
                delete temp;
            }
            menuAmount = 0;

            CartItemNode *currentOrder = cartHead;
            while (currentOrder != NULL)
            {
                CartItemNode *temp = currentOrder;
                currentOrder = currentOrder->next;
                delete temp;
            }
            cartAmount = 0;
        }
        void addMenuItem(MenuItem &item)
        {
            MenuItemNode *newNode = new MenuItemNode;
            newNode->data = item;
            newNode->next = NULL;

            if (menuHead == NULL)
            {
                menuHead = newNode;
            }
            else
            {
                MenuItemNode *current = menuHead;
                while (current->next != NULL)
                {
                    current = current->next;
                }
                current->next = newNode;
            }
            menuAmount++;
        }
        void loadData(std::string file)
        {
            std::fstream f;
            std::string name;
            MenuItem item;
            f.open(file, std::ios::in);
            if (f.is_open())
            {
                while (f >> name)
                {
                    f >> item.small >> item.medium >> item.large >> item.quantity;
                    item.name = name;
                    addMenuItem(item);
                }
                f.close();
            }
            else
            {
                std::cout << "Error opening menu file." << std::endl;
            }
        }
        bool updateMenuItem(int id, std::string n, float s, float m, float l, int q)
        {
            MenuItemNode *current = menuHead;
            MenuItem newItem;
            newItem.name = n;
            newItem.small = s;
            newItem.medium = m;
            newItem.large = l;
            newItem.quantity = q;

            while (current != NULL)
            {
                if (current->data.id == id)
                {
                    current->data = newItem;
                    return true;
                }
                current = current->next;
            }
            return false;
        }
        bool removeMenuItem(int id)
        {
            MenuItemNode *current = menuHead;
            MenuItemNode *previous = NULL;

            while (current != NULL)
            {
                if (current->data.id == id)
                {
                    if (previous == NULL)
                    {
                        menuHead = current->next;
                    }
                    else
                    {
                        previous->next = current->next;
                    }
                    menuAmount--;
                    delete current;
                    return true;
                }
                previous = current;
                current = current->next;
            }
            return false;
        }
        bool removeMenuItem(std::string name)
        {
            MenuItemNode *current = menuHead;
            MenuItemNode *previous = NULL;

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
                    menuAmount--;
                    delete current;
                    return true;
                }
                previous = current;
                current = current->next;
            }
            return false;
        }
        void showMenuItem()
        {
            cafe::MenuItemNode *current = menuHead;
            int i = 1;

            while (current != NULL)
            {
                std::cout << i << ". " << current->data.name << std::endl;
                std::cout << "   Small: $" << current->data.small << std::endl;
                std::cout << "   Medium: $" << current->data.medium << std::endl;
                std::cout << "   Large: $" << current->data.large << std::endl;
                std::cout << "   Quantity: " << current->data.quantity << std::endl;
                std::cout << std::endl;

                current = current->next;
                i++;
            }
        }

        void appendCart(MenuItem &item, std::string size, float price)
        {
            CartItemNode *newNode = new CartItemNode;
            newNode->data.id = item.id;
            newNode->data.productName = item.name;
            newNode->data.size = size;
            newNode->data.price = price;
            newNode->data.id = cartAmount;
            if (cartHead == NULL)
            {
                cartHead = newNode;
            }
            else
            {
                CartItemNode *current = cartHead;
                while (current->next != NULL)
                {
                    current = current->next;
                }
                current->next = newNode;
            }
            cartAmount++;
        }
        bool addToCart(int id, int s)
        {
            MenuItemNode *current = menuHead;
            MenuItem item;
            bool found = false;
            float price;
            std::string size;
            while (current != NULL)
            {
                if (current->data.id == id)
                {
                    item = current->data;
                    switch (s)
                    {
                    case 0: // small
                        price = item.small;
                        size = "Small";
                        break;
                    case 1: // medium
                        price = item.medium;
                        size = "Medium";
                        break;
                    case 2: // large
                        price = item.large;
                        size = "Large";
                        break;
                    default:
                        return false;
                    }
                    found = true;
                    break;
                }
                current = current->next;
            }
            if (!found)
            {
                return false;
            }
            appendCart(item, size, price);
            return true;
        }
        bool addToCart(std::string name, int s)
        {
            MenuItemNode *current = menuHead;
            MenuItem item;
            bool found = false;
            float price;
            std::string size;
            while (current != NULL)
            {
                if (current->data.name == name)
                {
                    item = current->data;
                    switch (s)
                    {
                    case 0: // small
                        price = item.small;
                        size = "Small";
                        break;
                    case 1: // medium
                        price = item.medium;
                        size = "Medium";
                        break;
                    case 2: // large
                        price = item.large;
                        size = "Large";
                        break;
                    default:
                        return false;
                    }
                    found = true;
                    break;
                }
                current = current->next;
            }
            if (!found)
            {
                return false;
            }
            appendCart(item, size, price);
            return true;
        }
        bool removeFromCart(int id)
        {
            CartItemNode *current = cartHead;
            CartItemNode *previous = NULL;

            while (current != NULL)
            {
                if (current->data.productId == id)
                {
                    if (previous == NULL)
                    {
                        cartHead = current->next;
                    }
                    else
                    {
                        previous->next = current->next;
                    }
                    cartAmount--;
                    delete current;
                    return true;
                }
                previous = current;
                current = current->next;
            }
            return false;
        }
        bool removeFromCart(std::string name)
        {
            CartItemNode *current = cartHead;
            CartItemNode *previous = NULL;

            while (current != NULL)
            {
                if (current->data.productName == name)
                {
                    if (previous == NULL)
                    {
                        cartHead = current->next;
                    }
                    else
                    {
                        previous->next = current->next;
                    }
                    cartAmount--;
                    delete current;
                    return true;
                }
                previous = current;
                current = current->next;
            }
            return false;
        }
    };

} // namespace cafe
#endif // CAFE_MANAGEMENT_H
