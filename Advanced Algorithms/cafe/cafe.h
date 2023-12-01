#ifndef CAFE_H
#define CAFE_H

#include <iostream>
#include <string>
#include <thread>
#include <chrono>
#include <ctime>
#include <stdlib.h>
#include <iomanip>
#include <algorithm>
#include <fstream>
#include <sstream>
#if defined(_WIN32) || defined(_WIN64)
#include <conio.h>
#else
#include <termios.h>
#include <unistd.h>

// Function to set and reset the terminal attributes for Mac
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
        std::cout << "\033[2J\033[1;1H";
    }

    void sleep(int seconds)
    {
        std::this_thread::sleep_for(std::chrono::seconds(seconds));
    }

    void sleep(int seconds, int milliseconds)
    {
        std::this_thread::sleep_for(std::chrono::seconds(seconds) + std::chrono::milliseconds(milliseconds));
    }

    int getInt() // a function to only get int as inputs
    {
        int n;
        while (!(std::cin >> n) || n < 0)
        {
            std::cout << "Invalid input. Try again: ";
            std::cin.clear();
            std::cin.ignore(1000, '\n');
        }
        return n;
    }

    int getInt(int max)
    {
        int n;
        while (!(std::cin >> n) || n > max || n < 0)
        {
            std::cout << "Invalid input. Try again: ";
            std::cin.clear();
            std::cin.ignore(1000, '\n');
        }
        return n;
    }

    float getFloat()
    {
        float n;
        std::string input;
        while (true)
        {
            std::getline(std::cin, input);
            std::istringstream iss(input);

            // Try extracting a float from the input
            if (iss >> n)
            {
                // Check if there are any trailing characters after the float
                char remaining;
                if (iss >> remaining)
                {
                    std::cout << "Invalid input. Try again: ";
                }
                else
                {
                    break; // Valid float input without extra characters
                }
            }
            else
            {
                std::cout << "Invalid input. Try again: ";
            }
        }
        return n;
    }

    bool isString(const std::string &input)
    {
        std::istringstream iss(input);
        int num;
        return !(iss >> num);
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

    void awaitEnter()
    {
#if defined(_WIN32) || defined(_WIN64)
        while (_getch() != 13)
        {
            // wait for the Enter key
            //  do nothing
        }
#else
        setTerminalMode(false);
        int c;
        while ((c = getchar()) != '\n' && c != EOF)
        {
            // Wait for the Enter key on Unix-like systems
        }

        setTerminalMode(true);
#endif
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

    bool validateAdmin(std::string username, std::string password)
    {
        std::fstream file;
        password = encrypt(password);
        std::string adminName, adminPass;
        file.open("data/secret.txt", std::ios::in);
        if (file.is_open())
        {
            file >> adminName >> adminPass;
        }
        else
        {
            std::cout << "Error: secret.txt file not found.\n";
        }
        file.close();
        return (username == adminName && password == adminPass);
    }

    struct MenuItem
    {
        int id;
        std::string name;
        float small, medium, large;
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
        int quantity;
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
            menuHead = nullptr;
            menuAmount = 0;
            cartHead = nullptr;
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
        void appendMenuItem(MenuItem &item)
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
        void addMenuItem(std::string name, float small, float medium, float large)
        {
            MenuItem item;
            item.name = name;
            item.small = small;
            item.medium = medium;
            item.large = large;
            item.id = menuAmount + 1;
            appendMenuItem(item);
        }
        void saveData(std::string file)
        {
            std::fstream f;
            f.open(file, std::ios::out);
            MenuItemNode *current = menuHead;
            if (f.is_open())
            {
                while (current != NULL)
                {
                    f << current->data.id << "|" << current->data.name << "|" << current->data.small << "|" << current->data.medium << "|" << current->data.large << std::endl;
                    current = current->next;
                }
                f.close();
            }
            else
            {
                std::cout << "Error opening menu file to save." << std::endl;
            }
        }
        void loadData(std::string file)
        {
            std::fstream f;
            MenuItem item;
            std::string line;
            f.open(file, std::ios::in);
            if (f.is_open())
            {
                while (std::getline(f, line))
                {
                    std::istringstream iss(line);
                    std::string token;

                    std::getline(iss, token, '|');
                    item.id = std::stoi(token);

                    std::getline(iss, token, '|');
                    item.name = token;

                    std::getline(iss, token, '|');
                    item.small = std::stof(token);

                    std::getline(iss, token, '|');
                    item.medium = std::stof(token);

                    std::getline(iss, token, '|');
                    item.large = std::stof(token);

                    appendMenuItem(item);
                }
                f.close();
            }
            else
            {
                std::cout << "Error opening menu file." << std::endl;
            }
        }
        bool updateMenuItem(int id, std::string n, float s, float m, float l)
        {
            MenuItemNode *current = menuHead;
            MenuItem newItem;
            newItem.id = id;
            newItem.name = n;
            newItem.small = s;
            newItem.medium = m;
            newItem.large = l;

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
        void updateItemIDs()
        {
            MenuItemNode *current = menuHead;
            int newID = 1;

            while (current != NULL)
            {
                current->data.id = newID;
                newID++;
                current = current->next;
            }
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
                    updateItemIDs();
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
        void showMenuItem(char border)
        {
            MenuItemNode *current = menuHead;

            std::cout << std::left << std::setfill(border) << std::setw(48) << "" << std::endl;
            while (current != NULL)
            {
                std::cout << std::left << std::setfill(' ') << std::setw(3) << current->data.id << " ";
                std::cout << std::left << std::setw(20) << current->data.name << " ";
                std::cout << "$" << std::fixed << std::setprecision(2) << std::setw(7) << current->data.small << " ";
                std::cout << "$" << std::fixed << std::setprecision(2) << std::setw(7) << current->data.medium << " ";
                std::cout << "$" << std::fixed << std::setprecision(2) << std::setw(7) << current->data.large << "\n";

                current = current->next;
            }
            std::cout << std::left << std::setfill(border) << std::setw(48) << "" << std::endl;
            std::cout << std::setfill(' ');
        }
        int getMenuAmount()
        {
            return menuAmount;
        }

        MenuItem *getMenuItem(std::string query)
        {
            MenuItemNode *current = menuHead;
            try
            {
                int intValue = std::stoi(query);
                while (current != nullptr)
                {
                    if (current->data.id == intValue)
                    {
                        return &(current->data);
                    }
                    current = current->next;
                }
            }
            catch (const std::invalid_argument &)
            {
                // query is not an integer
            }
            catch (const std::out_of_range &)
            {
                // query out of range for int
            }

            current = menuHead;
            while (current != nullptr)
            {
                if (current->data.name == query)
                {
                    return &(current->data);
                }
                current = current->next;
            }
            return nullptr;
        }

        void updateCartIDs()
        {
            CartItemNode *current = cartHead;
            int newID = 1;

            while (current != NULL)
            {
                current->data.id = newID;
                newID++;
                current = current->next;
            }
        }
        void appendCart(MenuItem &item, std::string size, float price, int quantity)
        {
            CartItemNode *newNode = new CartItemNode;
            newNode->data.productId = item.id;
            newNode->data.productName = item.name;
            newNode->data.size = size;
            newNode->data.price = price;
            newNode->data.quantity = quantity;
            newNode->data.id = cartAmount + 1;
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
        void addToCart(int id, int s, int q)
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
                        price = item.small * q;
                        size = "Small";
                        break;
                    case 1: // medium
                        price = item.medium * q;
                        size = "Medium";
                        break;
                    case 2: // large
                        price = item.large * q;
                        size = "Large";
                        break;
                    default:
                        return;
                    }
                    found = true;
                    break;
                }
                current = current->next;
            }
            if (!found)
            {
                return;
            }
            appendCart(item, size, price, q);
            return;
        }
        void addToCart(std::string name, std::string s, float p, int q)
        {
            CartItem newItem;
            CartItemNode *newCartNode = new CartItemNode;
            newItem.productName = name;
            newItem.price = p * q;
            newItem.quantity = q;
            newItem.size = s;
            newItem.productId = 0;
            newItem.id = cartAmount + 1;

            newCartNode->data = newItem;
            newCartNode->next = NULL;

            if (cartHead == NULL)
            {
                cartHead = newCartNode;
            }
            else
            {
                CartItemNode *current = cartHead;
                while (current->next != NULL)
                {
                    current = current->next;
                }
                current->next = newCartNode;
            }
            cartAmount++;
            return;
        }
        void addToCart(MenuItem *itemPtr, int s, int q)
        {
            MenuItem item = *itemPtr;
            float price;
            std::string size;
            switch (s)
            {
            case 0: // small
                price = item.small * q;
                size = "Small";
                break;
            case 1: // medium
                price = item.medium * q;
                size = "Medium";
                break;
            case 2: // large
                price = item.large * q;
                size = "Large";
                break;
            default:
                return;
            }
            appendCart(item, size, price, q);
            return;
        }
        // bool updateCart(int id, int s)
        // {
        //     CartItemNode *current = cartHead;
        //     MenuItem item;
        //     bool found = false;
        // }
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
        float getTotalPrice()
        {
            CartItemNode *current = cartHead;
            float total = 0;
            while (current != NULL)
            {
                total += current->data.price;
            }
            return total;
        }
        int getCartAmount()
        {
            return cartAmount;
        }
        void showCart()
        {
            CartItemNode *current = cartHead;
            while (current != NULL)
            {
                std::cout << std::left << std::setfill(' ') << std::setw(3) << current->data.id << " ";
                std::cout << std::left << std::setw(20) << current->data.productName << " ";
                std::cout << std::setw(8) << current->data.size << " ";
                std::cout << "$" << std::fixed << std::setprecision(2) << std::setw(7) << current->data.price << " ";
                std::cout << std::setw(7) << current->data.quantity << "\n";

                current = current->next;
            }
            std::cout << std::endl;
        }
        void checkout(std::string customer_name)
        {
            CartItemNode *current = cartHead;
            std::fstream f;
            auto now = std::chrono::system_clock::to_time_t(std::chrono::system_clock::now());

            // Convert to local time
            std::tm localTime = *std::localtime(&now);

            std::ostringstream oss;
            oss << std::put_time(&localTime, "%d/%m/%y %T");
            current_time = oss.str();
            f.open("data/history.txt", std::ios::app);
            //
            if (f.is_open())
            {
            }
            else
            {
                std::cout << "Error opening file" << std::endl;
            }
        }
    };

} // namespace cafe
#endif // CAFE_MANAGEMENT_H
